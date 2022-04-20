import 'package:zartech/home/models/item_carts.dart';
import 'package:bloc/bloc.dart';

import '../../core/util/utils.dart';
import 'chekout_event.dart';
import 'chekout_state.dart';

final tag = 'CheckoutBloc';

class CheckoutBloc extends Bloc<CheckOutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    var cartList = <ItemCart>[];

    on<GetData>((event, emit) async {
      log('fetchList', tag);
      try {
        emit(CheckoutLoading());
        print('fetchList $tag');
        var res = event.cartList;
        if (res != null) {
          print('fetchList ${res.length}   <<<<< ----->>>>> $tag');
          cartList = res;
          emit(CheckoutLoaded(cartList));
        } else {
          print('fetchList $tag   ListState.failure');
          emit(const CheckoutError('Something went wrong'));
        }
        print('fetchList LAST $tag');
      } catch (e) {
        print(e);
        emit(const CheckoutError('Something went wrong'));
      }
    });

    on<UpdateCart>((event, emit) {
      print('UpdateCart $tag');
      var temp = event.itemCart;
      if (cartList.isEmpty) {
        cartList.add(event.itemCart!);
        print('CartChanged add -->> ${cartList.length}  $tag');
      } else if (cartList.isNotEmpty) {
        print('CartChanged update -->> ${cartList.isNotEmpty}  $tag');
        var contain = false;
        for (var element in cartList) {
          if ((element.item?.dishId ?? '') == (temp?.item?.dishId ?? '')) {
            print('CartChanged cartList LENGTH -->> ${cartList.length}  $tag');
            print(
                'CartChanged cartList INDEX -->> ${cartList.indexOf(element)}  $tag');
            cartList[cartList.indexOf(element)] = temp!;
            contain = true;
            print('CartChanged contain -->> $contain  $tag');
            print('CartChanged cartList LENGTH -->> ${cartList.length}  $tag');
            break;
          }
        }
        if (!contain) {
          cartList.add(temp!);
        }
      }
      print('CartChanged SIZE -->> ${cartList.length}  $tag');
      emit(CheckoutChanged(cartList));
      emit(CheckoutChangeEnded(cartList));
    });
  }
}
