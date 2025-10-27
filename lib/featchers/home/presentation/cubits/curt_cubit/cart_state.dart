part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartItemAdd extends CartState {}

final class CartItemRemove extends CartState {}
