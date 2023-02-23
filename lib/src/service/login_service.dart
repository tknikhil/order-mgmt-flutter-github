import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:order_mgmt_flutter/src/constraints/api_constraints.dart';
import 'package:order_mgmt_flutter/src/json_request/json_req.dart';
import 'package:order_mgmt_flutter/src/model/model.dart';

// @lazySingleton
class LoginService {
  late final response;
  static var loginval;

  Future login(String username, String password) async {
    Object val;

    response = await http.post(Uri.parse('$baseUrl$loginPosts'),
        headers: <String, String>{"Content-type": "application/json"},
        body: JsonReq().loginEncode(username, password));
    final json = jsonDecode(response.body);

    final resultbody = json['result'];

    if (resultbody['errNo'] == 200) {
      val = 'Success';
      loginResponse();
    } else {
      val = 'Error';
    }
    return val;
  }

  loginResponse() {
    final json = jsonDecode(response.body);
    // final resultbody = json['result'];
    final loginData = json['data'];
    final customerDate = loginData['userDetails'];

    loginval = Login.fromJson(customerDate);

    return loginval;
  }
}
