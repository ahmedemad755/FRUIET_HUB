import 'dart:developer';

import 'package:e_commerce/core/functions_helper/get_dummy_product.dart';
import 'package:e_commerce/core/products_cubit/products_cubit.dart';
import 'package:e_commerce/core/widgets/custom_error_widget.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/products_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsGridViewBlocBuilder extends StatelessWidget {
  const ProductsGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess) {
          // ✅ الحالة الناجحة ترجّع SliverGrid مباشرة
          log("✅ Products loaded: ${state.products.length}");
          return ProductsGridView(products: state.products);
        } else if (state is ProductsFailure) {
          // ❌ CustomErrorWidget عادية، فلازم نحطها جوه SliverToBoxAdapter
          return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errMessage),
          );
        } else {
          // 🦴 حالة التحميل – ترجّع Sliver برضو (Skeletonizer.sliver)
          return Skeletonizer.sliver(
            enabled: true,
            child: ProductsGridView(products: getDummyProducts()),
          );
        }
      },
    );
  }
}
