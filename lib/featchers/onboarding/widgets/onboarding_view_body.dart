import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/constants.dart';

import 'package:e_commerce/core/functions_helper/routs.dart';
import 'package:e_commerce/core/services/shared_prefs_singelton.dart';

import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/featchers/onboarding/widgets/onboarding_pageView.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late PageController pageController;
  int currentPage = 0;

  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
    // Dispose of the page controller to free resources
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OnboardingPageview(
            pageController: pageController,
            currentPage: currentPage,
          ),
        ),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            color: currentPage == 1
                ? AppColors.primaryColor
                : const Color.fromARGB(125, 31, 94, 59), // Active color
            activeColor: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 29),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
          child: Visibility(
            visible: currentPage == 1 ? true : false,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            // Show button only on the first page
            child: CustomButton(
              onPressed: () async {
                await Prefs.setBool(kIsOnBoardingViewSeen, true);
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              },
              text: 'ابدأ الان',
            ),
          ),
        ),
        const SizedBox(height: 43),
      ],
    );
  }
}
