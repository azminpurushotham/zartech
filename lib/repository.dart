import 'dart:async';

import 'package:zartech/diohelper.dart';

import 'home/models/list_resp.dart';

class Repository {
  Future<ListResp> fetchItemsOnline(String key) async {
    var resp =
        await DioHelper().getDio().get<String>('5dfccffc310000efc8d2c1ad');
    return ListResp.fromJson(resp.extra);
  }
}
