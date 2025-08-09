import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_imags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.onItemTapped});
  final ValueChanged<int> onItemTapped;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  final List<_NavItemData> items = [
    _NavItemData(iconPath: Assets.home, label: 'الرئيسية'),
    _NavItemData(iconPath: Assets.product, label: 'المنتجات'),
    _NavItemData(iconPath: Assets.shoppingCart, label: 'سلة التسوق'),
    _NavItemData(iconPath: Assets.user, label: 'حسابي'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 18,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = selectedIndex == index;

          return Expanded(
            // ✅ الحل السحري
            child: GestureDetector(
              onTap: () {
                setState(() => selectedIndex = index);
                widget.onItemTapped(index);
              },
              child: AnimatedContainer(
                height: 45,
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green[100] : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      child: SvgPicture.asset(
                        item.iconPath,
                        color: isSelected ? Colors.white : Colors.grey,
                        width: 18,
                        height: 18,
                      ),
                    ),
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItemData {
  final String iconPath;
  final String label;
  const _NavItemData({required this.iconPath, required this.label});
}
