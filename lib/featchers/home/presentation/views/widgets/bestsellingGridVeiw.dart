import 'package:e_commerce/core/widgets/fruit_item.dart';
import 'package:flutter/material.dart';

class Bestsellinggridveiw extends StatelessWidget {
  const Bestsellinggridveiw({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 4, // Adjust the number of items as needed
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        childAspectRatio: 163 / 250,
      ),
      itemBuilder: (context, index) {
        return const FruitItem();
      },
    );
  }
}
