import 'package:e_commerce/core/enteties/product_enteti.dart';
import 'package:equatable/equatable.dart';

/// يمثل عنصر واحد في السلة (Item). فيه:
/// productIntety — بيانات المنتج (من AddProductIntety).
/// count — عدد نفس المنتج داخل السلة.
// ignore: must_be_immutable
class CartItemEntity extends Equatable {
  final AddProductIntety productIntety;

  int count;

  CartItemEntity({required this.productIntety, this.count = 0});

  num calculateTotalPrice() {
    return productIntety.price * count;
  }

  num calculateTotalWeight() {
    return productIntety.unitAmount * count;
  }

  incrementCount() {
    count++;
  }

  decrementCount() {
    if (count > 0) {
      count--;
    }
  }

  @override
  List<Object?> get props => [productIntety];
}
