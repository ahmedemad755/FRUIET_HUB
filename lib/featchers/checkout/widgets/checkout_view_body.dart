import 'package:e_commerce/core/functions_helper/build_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/featchers/checkout/domain/enteteis/order_entity.dart';
import 'package:e_commerce/featchers/checkout/widgets/check_out_steps_pageview.dart';
import 'package:e_commerce/featchers/checkout/widgets/checkout_steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  late PageController pageController;
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<AutovalidateMode> valueListenable = ValueNotifier(
    AutovalidateMode.disabled,
  );

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    valueListenable.dispose();
    super.dispose();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CheckoutSteps(
            currentIndex: currentPageIndex,
            onTap: (index) {
              setState(() => currentPageIndex = index);
            },
            pageController: pageController,
            formKey: formKey, // ✅ أضف المفتاح هنا
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CheckOutStepsPageView(
              pageController: pageController,
              formKey: formKey,
              valueListenable: valueListenable,
            ),
          ),
          const SizedBox(height: 20),
          CustomButtn(
            text: getNextButtonText(currentPageIndex),
            onPressed: () {
              if (currentPageIndex == 0) {
                _handleShippingSectionValidation(context);
              } else if (currentPageIndex == 1) {
                _handleAddressValidation();
              }
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _handleShippingSectionValidation(BuildContext context) {
    //بشوف انا ف اخر صفحه ولا لا
    if (context.read<OrderInputEntity>().payWithCash != null) {
      if (currentPageIndex < getsteps().length - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      showErrorBar(context, 'يرجي تحديد طريقه الدفع');
    }
  }

  String getNextButtonText(int currentPageIndex) {
    switch (currentPageIndex) {
      case 0:
        return 'التالي';
      case 1:
        return 'التالي';
      case 2:
        return 'الدفع عبر PayPal';
      default:
        return 'التالي';
    }
  }

  void _handleAddressValidation() {
    if (formKey.currentState!.validate()) {
      // ✅ تأكد من وجود دالة الحفظ هنا أيضاً
      formKey.currentState!.save();
      pageController.animateToPage(
        currentPageIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      valueListenable.value = AutovalidateMode.always;
      showErrorBar(context, 'يرجى تصحيح الأخطاء في حقول العنوان.');
    }
  }
}
