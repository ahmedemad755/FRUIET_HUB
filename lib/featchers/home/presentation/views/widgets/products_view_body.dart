import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/products_cubit/products_cubit.dart';
import 'package:e_commerce/core/widgets/search_text_feild.dart';
import 'package:e_commerce/featchers/auth/widgets/build_app_bar.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/products_grid_view_bloc_builder.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/products_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                buildAppBar(context, title: 'المنتجات', showBackButton: false),
                SizedBox(height: kTopPaddding),
                SearchTextFeild(),

                SizedBox(height: 12),
                ProductsHeader(
                  productsLength: context.read<ProductsCubit>().productsLength,
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          ProductsGridViewBlocBuilder(),
        ],
      ),
    );
  }
}
