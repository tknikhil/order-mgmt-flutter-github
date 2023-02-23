import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:order_mgmt_flutter/src/cubit/cubit.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class OrderSummeryPage extends StatefulWidget {
  var refNo;
  OrderSummeryPage({this.refNo, Key? key}) : super(key: key);
  @override
  State<OrderSummeryPage> createState() => _OrderSummeryPageState();
}

class _OrderSummeryPageState extends State<OrderSummeryPage> {
  var orderSummeryService = OrderSummeryService();
  String cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffbf1de),
      appBar: AppBarWidget(
        cdate: cdate,
        builder: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.keyboard_arrow_left),
              color: Colors.brown,
              onPressed: () => Navigator.of(context).pop()),
        ),
      ),
      body: BlocProvider(
        create: (context) => OrderSummeryCubit(OrderSummeryService()),
        child: OrderSummeryReader(widget.refNo),
      ),
    );
  }
}
