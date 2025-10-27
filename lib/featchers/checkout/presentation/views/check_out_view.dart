import 'package:e_commerce/featchers/AUTH/widgets/build_app_bar.dart'
    show buildAppBar;
import 'package:e_commerce/featchers/checkout/domain/enteteis/order_entity.dart'
    show OrderInputEntity;
import 'package:e_commerce/featchers/checkout/widgets/checkout_view_body.dart';
import 'package:e_commerce/featchers/home/domain/enteties/cart_entety.dart'
    show CartEntity;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key, required this.cartEntity});
  final CartEntity cartEntity;

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  late final OrderInputEntity orderInputEntity;

  @override
  void initState() {
    super.initState();
    orderInputEntity = OrderInputEntity(widget.cartEntity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'الشحن', showNotification: false),
      body: Provider.value(
        value: orderInputEntity,
        child: const CheckoutViewBody(),
      ),
    );
  }
}
