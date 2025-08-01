import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/functions_helper/build_error_bar.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:e_commerce/core/services/firebase_auth_service.dart';
import 'package:e_commerce/core/services/shared_prefs_singelton.dart';
import 'package:e_commerce/core/functions_helper/routs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required AuthRepoImpl authRepoImpl});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Center(child: Text('لم يتم تسجيل الدخول'));
    }

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(
                child: Text('لم يتم العثور على بيانات المستخدم'),
              );
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final userName = data['name'] ?? 'مستخدم';

            return AppBar(title: Text('أهلاً،$userName'), centerTitle: true);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuthService().logout();
              await Prefs.setBool("isLoggedIn", false);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("مرحبًا بك في الصفحة الرئيسية"),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _confirmDelete(context),
              icon: const Icon(Icons.delete),
              label: const Text('حذف الحساب'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد أنك تريد حذف الحساب نهائيًا؟'),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('حذف'),
            onPressed: () async {
              Navigator.pop(context);
              await _handleDelete(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        buildErroreBer(context, 'لا يوجد مستخدم حالياً.');
        return;
      }

      final userId = user.uid;

      // ✅ حذف المستخدم من Firebase Auth
      await user.delete();

      // ✅ حذف بيانات المستخدم من Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();

      // ✅ حذف حالة الدخول من SharedPreferences
      await Prefs.clear();

      // ✅ الانتقال إلى صفحة تسجيل الدخول
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        buildErroreBer(context, 'يجب تسجيل الدخول مرة أخرى قبل حذف الحساب.');
      } else {
        buildErroreBer(context, 'حدث خطأ: ${e.message}');
      }
    } catch (e) {
      buildErroreBer(context, 'فشل في حذف الحساب: ${e.toString()}');
    }
  }
}
