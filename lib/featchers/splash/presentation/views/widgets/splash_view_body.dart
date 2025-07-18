import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/functions_helper/routs.dart';
import 'package:e_commerce/core/services/shared_prefs_singelton.dart';
import 'package:e_commerce/core/utils/app_imags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    executeNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [SvgPicture.asset(Assets.plant)],
        ),
        SvgPicture.asset(Assets.logo),
        SvgPicture.asset(Assets.footerSplash, fit: BoxFit.fill),
      ],
    );
  }

  void executeNavigation() {
    final bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    final bool isLoggedIn = Prefs.getBool("isLoggedIn");

    Future.delayed(const Duration(seconds: 3), () {
      if (!isOnBoardingViewSeen) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      } else if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }
}
