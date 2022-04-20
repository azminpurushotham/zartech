import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartech/router.gr.dart';

import '../base/app_theme.dart';
import '../home/models/item_carts.dart';
import 'chekout_bloc.dart';
import 'chekout_event.dart';
import 'chekout_state.dart';

final String tag = 'Checkout';

class CheckoutPage extends StatefulWidget {
  CheckoutPage(this.cartList, {Key? key}) : super(key: key);
  final List<ItemCart> cartList;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CheckoutBloc bloc = CheckoutBloc();

  @override
  void initState() {
    bloc.add(GetData(widget.cartList));
    print('initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build $tag');
    var totalCount = getTotalItems(widget.cartList);
    return BlocProvider(
      create: (_) => bloc,
      child: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          print('listener BlocListener $tag');
          if (state is CheckoutError) {}
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getAppTheme(),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              leading: Container(
                width: 20,
                child: InkWell(
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                ),
              ),
              title: const Text(
                'Order Summary',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              leadingWidth: 120,
            ),
            body: BlocBuilder<CheckoutBloc, CheckoutState>(
              buildWhen: (previous, current) =>
                  (previous is CheckoutLoading) && (current is CheckoutLoaded),
              builder: (context, state) {
                print('BlocBuilder state --> $state  $tag');
                if (state is CheckoutLoading) {
                  print('CheckoutLoading $tag');
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CheckoutError) {
                  print('CheckoutError $tag');
                  return const Center(
                      child: Text('Oops something went wrong!'));
                } else if (state is CheckoutLoaded) {
                  return Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 15, 30, 15),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF1B5E20),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${widget.cartList.length}  Dishes - $totalCount Items',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.cartList.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ProductItem(
                                          items: widget.cartList[index]);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Amount ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        'INR ${getTotalAmount(widget.cartList)}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showSuccessDialog(context);
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFF1B5E20),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                'Place Order',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

String getTotalAmount(List<ItemCart> cartList) {
  var prince = 0.0;
  for (var item in cartList) {
    prince = prince + (item.count * (item?.item?.dishPrice ?? 0.0));
  }
  return prince.toString();
}

int getTotalItems(List<ItemCart> cartList) {
  int count = 0;
  for (var item in cartList) {
    count = count + item.count;
  }
  return count;
}

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.items,
  }) : super(key: key);

  final ItemCart items;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  TextEditingController cQty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cQty.text = widget.items.count.toString();
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          border: const Border(
              bottom: BorderSide(width: 0.5, color: Colors.black12)),
          color: Theme.of(context).backgroundColor),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getFoodType(widget.items.item?.dishType ?? 2),
                  Expanded(
                    child: Text(
                      widget.items.item?.dishName ?? 'Item Name',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Row(
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
                            var cart = ItemCart(temp, widget.items.item);
                            context.read<CheckoutBloc>().add(UpdateCart(cart));
                          },
                          child: Container(
                            width: 30,
                            height: 25,
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
                          height: 25,
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
                            height: 25,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      'INR ${widget.items.item?.dishPrice}',
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
              Text(
                // '${items?[index].dishCurrency}  ${items?[index].dishPrice}',
                'INR ${widget.items.item?.dishPrice}',
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              Text(
                '${widget.items.item?.dishCalories}  calories',
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              )
            ],
          ),
        ),
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

Future<void> showSuccessDialog(BuildContext _context) async {
  return showDialog<void>(
    context: _context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Message'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Order successfully placed'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              print('close dialogue');
              Navigator.pop(context);
              AutoRouter.of(_context).push(HomeRoute());
            },
          ),
        ],
      );
    },
  );
}
