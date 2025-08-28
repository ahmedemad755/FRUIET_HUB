import 'package:e_commerce/featchers/home/presentation/views/widgets/bestsellingGridVeiw.dart';
import 'package:flutter/material.dart';

class BestSelilingFruitesBody extends StatelessWidget {
  const BestSelilingFruitesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: Bestsellinggridveiw(itemcount: 12)),
      ),
    );
  }
}
