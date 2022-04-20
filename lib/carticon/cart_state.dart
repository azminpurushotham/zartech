import 'package:equatable/equatable.dart';

import '../home/models/item_carts.dart';

class CartState extends Equatable {
  CartState(this.cartCount);

  List<ItemCart> cartCount = [];

  CartState.updateCart(List<ItemCart> cartCount);

  @override
  List<Object> get props => [cartCount];
}
