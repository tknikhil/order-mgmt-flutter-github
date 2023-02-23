import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:order_mgmt_flutter/src/cubit/cubit.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';
class OrderDetailCardWidget extends StatefulWidget {
  const OrderDetailCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailCardWidget> createState() => _OrderDetailCardWidgetState();
}

class _OrderDetailCardWidgetState extends State<OrderDetailCardWidget> {

  @override
  Widget build(BuildContext context) {

    return BlocProvider<GetScreenLoadCubit>(
        create: (context)=>GetScreenLoadCubit(OrderService()),
        child: OrderListView()
    );
  }
}

