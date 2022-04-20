import 'dart:async';

import 'package:zartech/diohelper.dart';

import 'models/list_resp.dart';

class Repository {
  Future<List<ListResp>> fetchItemsOnline(String key) async {
    var resp = await DioHelper().getDio().get<List<dynamic>>(key);
    print('1');
    print('DioHelper-->> ${resp.data}');
    print('2');
    print('DioHelper-->> ${resp.data as List}');
    var temp = (resp.data as List).map(ListResp.fromJson).toList();
    print('3');
    print('DioHelper-->> ${temp.length}');
    return temp;
  }
}
