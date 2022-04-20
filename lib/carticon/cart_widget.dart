import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zartech/home/models/item_carts.dart';
import 'package:zartech/router.gr.dart';

import '../core/util/utils.dart';

final String tag = 'CartWidget';

class CartWidget extends StatelessWidget {
  CartWidget(this.cartList);

  final List<ItemCart> cartList;

  @override
  Widget build(BuildContext context) {
    print('CartWidget -->> ${cartList.length} $tag');
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              log('Cart click', tag);
              AutoRouter.of(context).push(CheckoutRoute(cartList: cartList));
            },
            child: Container(
                padding: const EdgeInsets.all(3),
                child: Image.asset(
                  'assets/images/ic_cart.png',
                  fit: BoxFit.fill,
                )),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.fromLTRB(3, 5, 3, 3),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: Text(
                cartList.length.toString() ?? '0',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
