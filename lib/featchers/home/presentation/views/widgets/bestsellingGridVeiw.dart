import 'package:e_commerce/core/widgets/fruit_item.dart';
import 'package:flutter/material.dart';

class Bestsellinggridveiw extends StatelessWidget {
  final int itemcount;
  const Bestsellinggridveiw({super.key, required this.itemcount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true, // مهم عشان يشتغل جوه ScrollView
      physics:
          const NeverScrollableScrollPhysics(), // عشان مايتعارضش مع ScrollView الأب
      itemCount: itemcount,
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
