// ignore_for_file: public_member_api_docs, sort_constructors_first
// Hide conflicting Column from drift
import 'dart:math';

import 'package:e_commerce/core/functions_helper/build_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/sugnup/sugnup_cubit.dart';
import 'package:e_commerce/featchers/auth/widgets/build_app_bar.dart';
import 'package:e_commerce/featchers/auth/widgets/cusstom_textfield.dart';
import 'package:e_commerce/featchers/auth/widgets/password_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/functions_helper/routs.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // Single import for Flutter

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
  late String email, password, userName;

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
              barrierDismissible: false, // يمنع إغلاق الـ Dialog بالضغط خارجها
              builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 10),
                    Text('نجاح'),
                  ],
                ),
                content: Text(state.successMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // إغلاق الـ Dialog
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.login);
                    },
                    child: Text('موافق'),
                  ),
                ],
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            });
          }
          if (state is SugnupFailure) {
            buildErroreBer(context, state.message);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SugnupLoading ? true : false,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      // Now correctly references Flutter's Column
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          onSaved: (value) {
                            userName = value!;
                          },
                          hintText: 'الاسم كامل',
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          onSaved: (value) {
                            email = value!;
                          },
                          hintText: 'البريد الإلكتروني',
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        PasswordField(
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                        const SizedBox(height: 8),

                        /// Terms and Conditions Checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              transform: Matrix4.identity()
                                ..scale(1.5)
                                ..rotateZ(
                                  _shouldShake
                                      ? 0.1 *
                                            sin(
                                              10 *
                                                  pi *
                                                  DateTime.now()
                                                      .millisecondsSinceEpoch /
                                                  1000,
                                            )
                                      : 0,
                                ),
                              child: Checkbox(
                                value: _isTermsAccepted,
                                onChanged: (value) {
                                  setState(() {
                                    _isTermsAccepted = value!;
                                  });
                                },
                                activeColor: AppColors.lightPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                side: const BorderSide(
                                  // الحدود لو مش متعلم
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'من خلال إنشاء حساب، فإنك توافق على الشروط والأحكام الخاصة بنا',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: _isTermsAccepted
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        /// Custom Button for Signup
                        CustomButton(
                          text: ' إنشاء حساب جديد',
                          onPressed: () {
                            if (!_isTermsAccepted) {
                              setState(() {
                                _shouldShake = true;
                              });
                              Future.delayed(Duration(seconds: 1), () {
                                setState(() {
                                  _shouldShake = false;
                                });
                              });
                              buildErroreBer(
                                context,
                                'يجب الموافقة على الشروط والأحكام أولاً',
                              );
                              return;
                            }
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context
                                  .read<SugnupCubit>()
                                  .createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                    name: userName,
                                  );
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                        ),

                        ///لتعطيل زر انشاء الحساب لو مش دايس علي الاتشيك بوكس
                        //   CustomButton(
                        //   text: 'إنشاء حساب جديد',
                        //   onPressed: _isTermsAccepted ? () {
                        //     if (formKey.currentState!.validate()) {
                        //       formKey.currentState!.save();
                        //       context.read<SugnupCubit>().createUserWithEmailAndPassword(
                        //         email: email,
                        //         password: password,
                        //         name: userName,
                        //       );
                        //     } else {
                        //       setState(() {
                        //         autovalidateMode = AutovalidateMode.always;
                        //       });
                        //     }
                        //   } : null, // null يعطل الزر
                        //   color: _isTermsAccepted ? AppColors.primaryColor : Colors.grey, // تغيير اللون عند التعطيل
                        // ),
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
                                    ..onTap = () {
                                      // نفذ اللي انت عايزه هنا لما المستخدم يضغط
                                      Navigator.of(
                                        context,
                                      ).pushReplacementNamed(
                                        AppRoutes.login,
                                      ); // مثال
                                    },
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
