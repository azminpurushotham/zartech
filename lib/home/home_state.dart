import 'package:equatable/equatable.dart';

import 'models/item_carts.dart';
import 'models/list_resp.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.list);

  final List<ListResp> list;
}

class HomeError extends HomeState {
  const HomeError(this.message);

  final String? message;
}

class CartChanged extends HomeState {
  const CartChanged(this.cartList);

  final List<ItemCart>? cartList;

  @override
  List<Object?> get props => [cartList];
}
class CartChangeEnded extends HomeState {
  const CartChangeEnded(this.cartList);

  final List<ItemCart>? cartList;

  @override
  List<Object?> get props => [cartList];
}
