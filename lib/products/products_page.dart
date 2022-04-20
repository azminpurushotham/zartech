import 'package:zartech/home/home_bloc.dart';
import 'package:zartech/home/home_event.dart';
import 'package:zartech/home/models/list_resp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../home/models/item_carts.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage(
    this.element, {
    Key? key,
  }) : super(key: key);
  final TableMenuList element;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<CategoryDishes>? items;

  @override
  Widget build(BuildContext context) {
    items = widget.element.categoryDishes;
    return ListView.builder(
      itemCount: items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return ProductItem(items: items![index]);
      },
    );
  }
}

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.items,
  }) : super(key: key);

  final CategoryDishes items;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  TextEditingController cQty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          border: const Border(
              bottom: BorderSide(width: 0.5, color: Colors.black12)),
          color: Theme.of(context).backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getFoodType(widget.items.dishType!),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.items.dishName ?? 'Item Name',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '${items?[index].dishCurrency}  ${items?[index].dishPrice}',
                          'INR ${widget.items.dishPrice}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        Text(
                          '${widget.items.dishCalories}  calories',
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.items.dishDescription ?? 'Description',
                      style: const TextStyle(
                          color: Colors.black45,
                          fontFamily: 'Gilroy',
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            var temp = 0;
                            if (cQty.value.text.isEmpty) {
                              temp = 1;
                            } else {
                              temp = int.parse(cQty.value.text);
                              temp++;
                            }
                            cQty.text = temp.toString();
                            print('added -->> $temp');
                            var cart = ItemCart(temp, widget.items);
                            context.read<HomeBloc>().add(UpdateCart(cart));
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            child: const Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                          decoration: const BoxDecoration(color: Colors.green),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 18,
                                )),
                            controller: cQty,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            var temp = 0;
                            if (cQty.value.text.isEmpty) {
                              temp = 0;
                            } else {
                              temp = int.parse(cQty.value.text);
                              temp--;
                            }
                            if (temp >= 0) {
                              cQty.text = temp.toString();
                            } else {
                              temp = 0;
                              cQty.text = temp.toString();
                            }
                            print('added -->> $temp');
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: const Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: widget.items.addonCat?.isNotEmpty ?? false,
                      child: const Text(
                        'Customizations Available',
                        style: TextStyle(color: Colors.red, fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 80,
              width: 80,
              child: Image.network(
                'https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container getFoodType(int dishType) {
  if (dishType == 2) {
    return Container(
      height: 20,
      width: 20,
      child: Image.asset(
        'assets/images/ic_veg.png',
        height: 20,
        width: 20,
        fit: BoxFit.fill,
      ),
    );
  } else {
    return Container(
      height: 20,
      width: 20,
      child: Image.asset(
        'assets/images/ic_non_veg.png',
        height: 20,
        width: 20,
        fit: BoxFit.fill,
      ),
    );
  }
}
