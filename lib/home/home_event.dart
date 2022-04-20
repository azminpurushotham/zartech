import 'package:zartech/home/models/item_carts.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetData extends HomeEvent {}

class UpdateCart extends HomeEvent {
  const UpdateCart(this.itemCart);

  final ItemCart? itemCart;
}
