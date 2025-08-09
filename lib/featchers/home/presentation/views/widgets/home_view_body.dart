import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/widgets/search_text_feild.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/bestsellingGridVeiw.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/bestsellingheader.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/featured_list.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomHomeAppBar(),
                SizedBox(height: kTopPaddding),
                SearchTextFeild(),
                SizedBox(height: 12),
                FeaturedList(),
                SizedBox(height: 12),
                BestSellingHeader(),
                SizedBox(height: 12),

                // Add other widgets here, like categories, products, etc.
              ],
            ),
          ),
          Bestsellinggridveiw(),
        ],
      ),
    );
  }
}
