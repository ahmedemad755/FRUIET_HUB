import 'package:e_commerce/featchers/checkout/domain/enteteis/shipping_address_entity.dart';
import 'package:e_commerce/featchers/home/domain/enteties/cart_entety.dart';

class OrderInputEntity {
  // final String uID;
  final CartEntity cartEntity;
  bool? payWithCash;
  ShippingAddressEntity shippingAddressEntity;
  OrderInputEntity(
    this.cartEntity, {
    this.payWithCash,
    ShippingAddressEntity? shippingAddressEntity,
  }) : shippingAddressEntity = shippingAddressEntity ?? ShippingAddressEntity();
}
