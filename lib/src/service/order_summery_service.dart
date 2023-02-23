import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:order_mgmt_flutter/src/constraints/constraints.dart';

import '../model/model.dart';

class OrderSummeryService {
  static var orderSummery;

  Future<dynamic> getOrderDetail(refNo) async {
    try {
      final uri = Uri.parse('$baseUrl$dsplyOrdrDtl/$refNo');
      final response = await http.get(uri);
      final json = jsonDecode(response.body);

      final resultbody = json['result'];
      if (resultbody['errNo'] == 200) {
        final json = jsonDecode(response.body);
        final getData = json['data'];
        final listResponse = getData['custOrdrDtlsByRefNo'];
        print('$listResponse listResponse');
        orderSummery=OrderSummery.fromJson(listResponse);
        return orderSummery;
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
