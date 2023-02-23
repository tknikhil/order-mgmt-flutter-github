import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:order_mgmt_flutter/src/constraints/constraints.dart';
import 'package:order_mgmt_flutter/src/model/model.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';

class OrderService {
  Future<List<OrderDetail>> getScreenOnLoad() async {
    try {
      final uri = Uri.parse(
          '$baseUrl$custOrdrDsplyUrl/${LoginService.loginval.userCode.toString()}');
      final response = await http.get(uri);
      final json = jsonDecode(response.body);

      final resultbody = json['result'];
      if (resultbody['errNo'] == 200) {
        final getData = json['data'];
        final listResponse = getData['customerOrdrDtls'];
        final orderDetails = listResponse
            .map<OrderDetail>((e) => OrderDetail.fromJson(e))
            .toList() as List<OrderDetail>;
        return orderDetails;
      } else {
        // throw Exception('Unable to load data ${response.body}');
        throw Exception('Unable to load data ${response}');
      }
    } catch (err) {
      if (kDebugMode) {
        print("Error :$err");
      }
      rethrow; //other wise it say's method has potential of returning null
    }
  }
}
