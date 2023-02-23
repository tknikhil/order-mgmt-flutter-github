import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:order_mgmt_flutter/src/constraints/constraints.dart';
import 'package:order_mgmt_flutter/src/json_request/json_req.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';

class PersisItemService {
  Future saveItem(
      String itemName,
      double? weight,
      String? itemSize,
      int? qty,
      double? meltPer,
      String? stamp,
      String? hook,
      String? designSample,
      String? sizeSample,
      String? refNo,
      List<String>? imageData,
      String? remark,
      int days) async {
    Object val;

    var response = await http.post(
        Uri.parse('$baseUrl/${LoginService.loginval.userCode.toString()}'),
        headers: <String, String>{"Content-type": "application/json"},
        body: JsonReq().saveItem(
            itemName,
            weight!,
            itemSize!,
            qty!,
            meltPer!,
            stamp!,
            hook!,
            designSample!,
            sizeSample!,
            refNo!,
            imageData!,
            remark!,
            days));

    final json = jsonDecode(response.body);

    final resultBody = json['result'];

    if (resultBody['errNo'] == 200) {
      val = resultBody['errMsg'].toString();
    } else {
      val = resultBody['errMsg'].toString();
    }
    return val;
  }
}
