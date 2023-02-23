import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:order_mgmt_flutter/src/constraints/constraints.dart';
import 'package:order_mgmt_flutter/src/model/model.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';

class AddItemService {
  Future<List<ItemName>> addItemNameLoad() async {
    final uri = Uri.parse('$baseUrl$scrOnLoad');
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final data = json['data'];
    final itemNameList = data['itemNameList'];
    final itemNameDtl = itemNameList
        .map<ItemName>((e) => ItemName.fromJson(e))
        .toList() as List<ItemName>;
    return itemNameDtl;
  }

  Future<String> getStamp(String meltval) async {
    final uri = Uri.parse(
        '$baseUrl$meltPer/$meltval/${LoginService.loginval.userCode.toString()}');
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final data = json['data'];
    return data['meltingStamp']['stamp'];
  }

  Future<String> getDueDate(String days) async {
    final uri = Uri.parse('$baseUrl$dueDate/$days');
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final data = json['data'];
    return data['dueDate'];
  }
}
