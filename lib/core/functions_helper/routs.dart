import 'package:e_commerce/core/di/injection.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/login/login_cubit.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/sugnup/sugnup_cubit.dart';
import 'package:e_commerce/featchers/auth/view/login_view.dart';
import 'package:e_commerce/featchers/auth/view/signup.dart';
import 'package:e_commerce/featchers/home/home.dart';
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
      return MaterialPageRoute(builder: (_) => const HomePage());

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
