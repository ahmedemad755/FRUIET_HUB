import 'package:e_commerce/featchers/checkout/domain/enteteis/order_entity.dart';
import 'package:e_commerce/featchers/checkout/widgets/payment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_text_styles.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({super.key, required this.pageController});

  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    // log(context.read<OrderInputEntity>().toString());
    final order = context.watch<OrderInputEntity>();
    final shippingAddress = order.shippingAddressEntity;
    return PaymentItem(
      tile: 'عنوان التوصيل',
      child: Row(
        children: [
          Icon(Icons.location_pin),
          const SizedBox(width: 8),
          Text(
            shippingAddress.toStrings(),
            textAlign: TextAlign.right,
            style: TextStyles.regular13.copyWith(
              color: const Color(0xFF4E5556),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            child: SizedBox(
              child: Row(
                children: [
                  Icon(Icons.edit),
                  const SizedBox(width: 4),
                  Text(
                    'تعديل',
                    style: TextStyles.semiBold13.copyWith(
                      color: const Color(0xFF949D9E),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
