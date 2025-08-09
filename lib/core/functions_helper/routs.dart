import 'package:e_commerce/core/di/injection.dart';
import 'package:e_commerce/featchers/AUTH/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/AUTH/data/repos/auth_repo_impl.dart';
import 'package:e_commerce/featchers/AUTH/presentation/cubits/login/login_cubit.dart';
import 'package:e_commerce/featchers/AUTH/presentation/cubits/signup/sugnup_cubit.dart';
import 'package:e_commerce/featchers/AUTH/presentation/cubits/vereficationotp/vereficationotp_cubit.dart';
import 'package:e_commerce/featchers/AUTH/presentation/view/forgot_password_view.dart';
import 'package:e_commerce/featchers/AUTH/presentation/view/login_view.dart';
import 'package:e_commerce/featchers/AUTH/presentation/view/oTPVerificationScreen.dart';
import 'package:e_commerce/featchers/AUTH/presentation/view/reset_Password.dart';
import 'package:e_commerce/featchers/AUTH/presentation/view/signup.view.dart';
import 'package:e_commerce/featchers/home/presentation/views/home_veiw.dart';
import 'package:e_commerce/featchers/onboarding/views/onboarding_view.dart';
import 'package:e_commerce/featchers/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String home = 'home';
  static const String forgotPassword = 'forgotPassword';
  static const String otp = 'otp';
  static const String sendResetPassword = 'sendResetPassword';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case AppRoutes.onboarding:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (_) {
          return BlocProvider(
            create: (context) => LoginCubit(getIt<AuthRepo>()),
            child: Builder(builder: (context) => const LoginView()),
          );
        },
      );
    case AppRoutes.home:
      return MaterialPageRoute(
        builder: (_) => HomePage(authRepoImpl: getIt<AuthRepoImpl>()),
      );
    case AppRoutes.forgotPassword:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<OTPCubit>(),
          child: ForgotPasswordScreen(),
        ),
      );

    case AppRoutes.otp:
      final args = settings.arguments as Map<String, dynamic>;
      final otpCubit = args['cubit'] as OTPCubit;
      final phoneNumber = args['phone'] as String?;
      return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: otpCubit,
          child: OTPVerificationScreen(phoneNumber: phoneNumber),
        ),
      );

    case AppRoutes.sendResetPassword:
      return MaterialPageRoute(builder: (_) => const SendResetPassword());

    case AppRoutes.signup:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => SugnupCubit(getIt<AuthRepo>()),
          child: const Signup(),
        ),
      );
    default:
      return MaterialPageRoute(builder: (_) => Scaffold());
  }
}
