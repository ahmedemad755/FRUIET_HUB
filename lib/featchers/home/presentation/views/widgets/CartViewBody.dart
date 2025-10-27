import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/widgets/castom_cart_buttom.dart';
import 'package:e_commerce/featchers/auth/widgets/build_app_bar.dart';
import 'package:e_commerce/featchers/home/presentation/cubits/curt_cubit/cart_cubit.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/CartHeader.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/cart_items_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: kTopPaddding),
                  buildAppBar(context, title: 'السلة', showBackButton: false),
                  const SizedBox(height: 16),
                  const CartHeader(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: context.read<CartCubit>().cartEntity.cartItems.isEmpty
                  ? const SizedBox()
                  : const CustomDivider(),
            ),
            CartItemsList(
              carItems: context.watch<CartCubit>().cartEntity.cartItems,
            ),
            SliverToBoxAdapter(
              child: context.read<CartCubit>().cartEntity.cartItems.isEmpty
                  ? const SizedBox()
                  : const CustomDivider(),
            ),
          ],
        ),

        Positioned(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).size.height * 0.09,
          child: CustomCartButton(),
        ),
      ],
    );
  }
}
