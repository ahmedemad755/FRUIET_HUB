import 'package:e_commerce/core/functions_helper/routs.dart';
import 'package:e_commerce/featchers/AUTH/presentation/cubits/vereficationotp/vereficationotp_cubit.dart';
import 'package:e_commerce/featchers/AUTH/presentation/cubits/vereficationotp/vereficationotp_state.dart';
import 'package:e_commerce/featchers/AUTH/widgets/builedotpinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  const OTPVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OTPCubit, OTPState>(
        listener: (context, state) async {
          if (state is OTPLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          }

          if (state is OTPVerified) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isOTPVerified', true);

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('تم التحقق بنجاح ✅')));

            Navigator.pushNamed(
              context,
              AppRoutes.sendResetPassword, // تأكد تستخدم widget.phoneNumber
            );
          } else if (state is OTPError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButton(),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'التحقق من الرمز',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'أدخل الرمز الذي أرسلناه إلى رقم الهاتف التالي:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          widget.phoneNumber ?? 'رقم غير متوفر',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        // حقل إدخال كود OTP
                        buildOTPInputField(context, codeController),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              final code = codeController.text.trim();
                              if (code.length == 6) {
                                context.read<OTPCubit>().verifyCode(code);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'من فضلك أدخل رمز مكون من 6 أرقام',
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[800],
                            ),
                            child: const Text(
                              'تحقق من الرمز',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            final phone = widget.phoneNumber!;
                            context.read<OTPCubit>().sendOTP(phone);
                          },
                          child: const Text(
                            'إعادة إرسال الرمز',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
