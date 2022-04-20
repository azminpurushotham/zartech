import 'package:equatable/equatable.dart';

import 'list_resp.dart';

class ItemCart extends Equatable {
  ItemCart(this.count, this.item);

  final int count;
  final CategoryDishes? item;

  @override
  List<Object?> get props => [count, item];

}
