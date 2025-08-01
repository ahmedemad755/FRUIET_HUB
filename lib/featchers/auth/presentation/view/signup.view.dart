// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/functions_helper/build_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/signup/sugnup_cubit.dart';
import 'package:e_commerce/featchers/auth/widgets/build_app_bar.dart';
import 'package:e_commerce/featchers/auth/widgets/cusstom_textfield.dart';
import 'package:e_commerce/featchers/auth/widgets/password_field.dart';
import 'package:e_commerce/featchers/auth/widgets/showtermsandcondetions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/functions_helper/routs.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isTermsAccepted = false;
  bool _shouldShake = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late String email, password, userName, role;

  void setTermsAccepted(bool value) => setState(() => _isTermsAccepted = value);

  void _submitForm() async {
    if (!_isTermsAccepted) {
      setState(() => _shouldShake = true);
      Future.delayed(
        const Duration(seconds: 1),
        () => setState(() => _shouldShake = false),
      );
      buildErroreBer(context, 'يجب الموافقة على الشروط والأحكام أولاً');
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      print("🔍 [Signup] email=$email, password=$password");

      if (email.trim().isEmpty || password.trim().isEmpty) {
        buildErroreBer(context, 'الرجاء ملء الحقول بشكل صحيح');
        return;
      }

      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          buildErroreBer(context, 'البريد الإلكتروني مستخدم بالفعل');
          return;
        }

        context.read<SugnupCubit>().createUserWithEmailAndPassword(
          email: email,
          password: password,
          name: userName,
          role: role,
        );
      } catch (e) {
        buildErroreBer(context, "حدث خطأ أثناء الاتصال بالخادم: $e");
        print("=================Error during signup: $e");
      }
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..scale(1.5)
            ..rotateZ(
              _shouldShake
                  ? 0.1 *
                        sin(
                          10 *
                              pi *
                              DateTime.now().millisecondsSinceEpoch /
                              1000,
                        )
                  : 0,
            ),
          child: Checkbox(
            value: _isTermsAccepted,
            onChanged: (value) => setTermsAccepted(value!),
            activeColor: AppColors.lightPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: const BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'من خلال إنشاء حساب، فإنك توافق على ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: _isTermsAccepted ? Colors.grey : Colors.red,
              ),
              children: [
                TextSpan(
                  text: 'الشروط والأحكام',
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        showTermsAndConditionsDialog(context, setTermsAccepted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: ' حساب جديد'),
      body: BlocConsumer<SugnupCubit, SugnupState>(
        listener: (context, state) {
          if (state is SugnupSuccess) {
            SystemSound.play(SystemSoundType.click);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 10),
                    Text('نجاح'),
                  ],
                ),
                content: Text(state.successMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.login),
                    child: const Text('موافق'),
                  ),
                ],
              ),
            );
            Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            );
          } else if (state is SugnupFailure) {
            buildErroreBer(context, state.message);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SugnupLoading,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          onSaved: (value) => userName = value!,
                          hintText: 'الاسم كامل',
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          onSaved: (value) => email = value!,
                          hintText: 'البريد الإلكتروني',
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        PasswordField(onSaved: (value) => password = value!),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "النوع",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'user',
                              child: Text('مستخدم'),
                            ),
                            DropdownMenuItem(
                              value: 'technician',
                              child: Text('فني'),
                            ),
                          ],
                          onChanged: (value) => setState(() => role = value!),
                          onSaved: (value) => role = value!,
                          validator: (value) =>
                              value == null ? 'يرجى اختيار النوع' : null,
                        ),
                        const SizedBox(height: 8),
                        _buildTermsCheckbox(),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: ' إنشاء حساب جديد',
                          onPressed: _submitForm,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'تمتلك حساب بالفعل؟ ',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'تسجيل دخول',
                                  style: TextStyle(
                                    color: AppColors.lightPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(
                                      context,
                                    ).pushReplacementNamed(AppRoutes.login),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
