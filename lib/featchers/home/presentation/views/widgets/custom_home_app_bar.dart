import 'package:e_commerce/core/utils/app_imags.dart';
import 'package:e_commerce/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        padding: const EdgeInsets.all(12),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFEEF8ED),
        ),
        child: SvgPicture.asset(Assets.notification),
      ),
      leading: Image.asset(Assets.profileimage),
      title: Text(
        'صباح الخير !..',
        textAlign: TextAlign.right,
        style: TextStyles.regular16.copyWith(color: const Color(0xFF949D9E)),
      ),
      subtitle: Text(
        "أحمد مصطفي",
        textAlign: TextAlign.right,
        style: TextStyles.bold16,
      ),
    );
  }
}
