import 'package:e_commerce/core/utils/app_imags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNaviagtion();
    super.initState();
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

  void excuteNaviagtion() {
    // bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 3), () {
      // if (isOnBoardingViewSeen) {
      //   // var isLoggedIn = FirebaseAuthService().isLoggedIn();

      //   if (isLoggedIn) {
      //     Navigator.pushReplacementNamed(context, MainView.routeName);
      //   } else {
      //     Navigator.pushReplacementNamed(context, SigninView.routeName);
      //   }
      // } else {
      //   Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      // }
    });
  }
}
