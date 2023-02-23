import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:order_mgmt_flutter/src/cubit/cubit.dart';
import 'package:order_mgmt_flutter/src/model/model.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class OrderListView extends StatefulWidget {
  static var refnoval;
  static List<OrderDetail> orderDetail = [];
  late List<OrderDetail> filterderOrder = [];

  OrderListView({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderListView> createState() => OrderListViewState();

}

class OrderListViewState extends State<OrderListView> {
  search(TextEditingController searchController) {}

  runFilter2(String enteredKeyword) async {
    var results = await OrderService().getScreenOnLoad();
    if (enteredKeyword.isEmpty) {
      results = OrderListView.orderDetail;
    } else {
      results = OrderListView.orderDetail.where((element) {
        var resultRefNo = element.refNo;
        return resultRefNo!.contains(enteredKeyword);
      }).toList();
      if (mounted) {
        setState(() {
          OrderListView.orderDetail = results;
        });
      }
    }
  }

  late OrderSummeryService orderSummeryService;
  late final cubit;
  List<OrderDetail> _newOrderDetail = [];

//initState is called before widget tree
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit = context.read<GetScreenLoadCubit>();
      cubit.loadCustmrOrdrData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [buildBlocBuilder()]);
  }

  //List<OrderDetail> instead of cubit state
  BlocBuilder<GetScreenLoadCubit, GetScreenLoadState> buildBlocBuilder() {
    return BlocBuilder<GetScreenLoadCubit, GetScreenLoadState>(
      builder: (context, state) {
        if (state is GetScreenLoadInitial || state is LoadingScreenLoadState) {
          return const Center(child: CircularProgressIndicator());
        } //GetScreenLoadInitial, LoadingScreenLoadState
        else if (state is ResponseScreenLoadState) {
          widget.filterderOrder = state.orderDetial;
          OrderListView.orderDetail = widget.filterderOrder;
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: OrderListView.orderDetail.length,
                    itemBuilder: (context, index) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: buildCard(index),
                          ),
                        )),
              ],
            ),
          );
        } //ResponseScreenLoadState
        else if (state is ErrorScreenLoadState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text(state.toString()),
          );
        }
      },
    );
  }

  Card buildCard(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4,
      shadowColor: Colors.grey,
      child: buildDataTable(index),
    );
  }

  static var refnoval;

  ListTile buildDataTable(int index) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderSummeryPage(
                    refNo: OrderListView.orderDetail[index].refNo)));
        refnoval = OrderListView.orderDetail[index].refNo;
      },
      title: DataTable(
        columns: [
          DataColumn(
              label: Text(
            'Ref no.:${OrderListView.orderDetail[index].refNo.toString()}',
            style: const TextStyle(fontSize: 17),
          )),
          DataColumn(
              label: Text(
            OrderListView.orderDetail[index].status.toString(),
            style: TextStyle(
                fontSize: 17,
                color: (OrderListView.orderDetail[index].status == 'Assigned')
                    ? Colors.green
                    : (OrderListView.orderDetail[index].status == 'Confirmed')
                        ? Colors.green
                        : Colors.red),
          )),
        ],
        rows: [
          DataRow(cells: [
            DataCell(
              Text(
                'Order Date',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(Text(
              '${OrderListView.orderDetail[index].formatedDueDate.toString()}',
              style: TextStyle(
                fontSize: 15,
              ),
            ))
          ]),
          DataRow(cells: [
            DataCell(
              Text(
                'Item Name',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(Text(
              '${OrderListView.orderDetail[index].itemName.toString()}',
              style: TextStyle(
                fontSize: 17,
              ),
            ))
          ])
        ],
      ),
    );
  }
}
