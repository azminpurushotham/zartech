import 'package:zartech/home/models/item_carts.dart';
import 'package:zartech/home/repository.dart';
import 'package:bloc/bloc.dart';

import '../../core/util/utils.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'models/list_resp.dart';

final tag = 'HomeBloc';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final repository = Repository();
    var cartList = <ItemCart>[];

    on<GetData>((event, emit) async {
      log('fetchList', tag);
      try {
        emit(HomeInitial());
        emit(HomeLoading());
        print('fetchList $tag');
        var res = await repository.fetchItemsOnline('5dfccffc310000efc8d2c1ad');
        if (res[0].tableMenuList != null) {
          print(
              'fetchList ${res[0].tableMenuList?.length}   <<<<< ----->>>>> $tag');
          emit(HomeLoaded(res));
        } else {
          print('fetchList $tag   ListState.failure');
          emit(const HomeError('Something went wrong'));
        }
        print('fetchList LAST $tag');
      } catch (e) {
        print(e);
        emit(const HomeError('Something went wrong'));
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
      emit(CartChanged(cartList));
      emit(CartChangeEnded(cartList));
    });
  }
}
