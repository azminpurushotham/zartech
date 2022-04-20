import 'package:equatable/equatable.dart';

import '../home/models/item_carts.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  const CheckoutLoaded(this.list);

  final List<ItemCart> list;
}

class CheckoutError extends CheckoutState {
  const CheckoutError(this.message);

  final String? message;
}

class CheckoutChanged extends CheckoutState {
  const CheckoutChanged(this.cartList);

  final List<ItemCart>? cartList;

  @override
  List<Object?> get props => [cartList];
}

class CheckoutChangeEnded extends CheckoutState {
  const CheckoutChangeEnded(this.cartList);

  final List<ItemCart>? cartList;

  @override
  List<Object?> get props => [cartList];
}
