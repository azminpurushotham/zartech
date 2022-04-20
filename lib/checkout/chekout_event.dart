import 'package:zartech/home/models/item_carts.dart';
import 'package:equatable/equatable.dart';

abstract class CheckOutEvent extends Equatable {
  const CheckOutEvent();

  @override
  List<Object> get props => [];
}

class GetData extends CheckOutEvent {
  GetData(this.cartList);

  List<ItemCart> cartList;
}

class UpdateCart extends CheckOutEvent {
  const UpdateCart(this.itemCart);

  final ItemCart? itemCart;
}
