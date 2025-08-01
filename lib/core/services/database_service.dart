import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Databaseservice {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String documentId,
  });

  Future<Map<String, dynamic>> getData({
    required String path,
    required String DcumentId,
  });

  Future<void> setData({
    required String path, // اسم الكولكشن
    required String id, // الـ document ID، غالبًا UID المستخدم
    required Map<String, dynamic> data,
    // البيانات اللي هتتسجل
  }) async {
    await FirebaseFirestore.instance
        .collection(path) // ← الكولكشن زي 'users'
        .doc(id) // ← المستند داخل الكولكشن
        .set(
          data,
          SetOptions(merge: true),
        ); // ← دمج البيانات بدل الكتابة الكاملة
  }

  Future<bool> checkIfDataExists({
    required String documentId,
    required String path,
  });
}
