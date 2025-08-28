import 'package:e_commerce/featchers/best_selling_fruites/presentations/views/widgets/Best_Seliling_Fruites_body.dart';
import 'package:e_commerce/featchers/best_selling_fruites/presentations/views/widgets/build_appBar.dart';
import 'package:flutter/material.dart';

class BestSelilingFruitesView extends StatelessWidget {
  const BestSelilingFruitesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: build_App_Bar(context, title: 'الأكثر مبيعًا'),
      body: BestSelilingFruitesBody(),
    );
  }
}
