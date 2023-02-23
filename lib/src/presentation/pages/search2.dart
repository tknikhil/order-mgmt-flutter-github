import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:order_mgmt_flutter/src/model/model.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class Search2 extends StatefulWidget {
  const Search2({Key? key}) : super(key: key);

  @override
  State<Search2> createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  var results;
  var orderService = OrderService();
  late List<OrderDetail> orderDetails = [];
  late List<OrderDetail> filteredOrders = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    final searchController = TextEditingController();
    final orderListView = OrderListView();
    return WillPopScope(
      //for system navigation bar back button ask permission to exit
      onWillPop: () async {
        final val = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text('Do you want to exit?'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes')),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No')),
                ],
              );
            });
        if (val != null) {
          return Future.value(val);
        } else {
          return Future.value(false);
        }
      },
      child: SizedBox(
        //takes host mobile complete screen size
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          //drawer
          drawer: const MenuDrawer(),
          //appbar
          appBar: AppBarWidget(
              cdate: cdate,
              builder: Builder(
                builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    color: Colors.brown,
                    onPressed: () => Scaffold.of(context).openDrawer()),
              )),
          backgroundColor: const Color(0xfffd4af37),
          body: RefreshIndicator(
            onRefresh: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (a, b, c) => BottomNavigationBarPage(),
                      transitionDuration: Duration(seconds: 0)));
              return Future.value(false);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      searchByRef(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    child: Container(
                      color: const Color(0xffff0ead6),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //card
                              buildSingleChildScrollView(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              // scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) => buildSizedBox(context, index)),
        ],
      ),
    );
  }

  SizedBox buildSizedBox(BuildContext context, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: buildCard(index),
      ),
    );
  }

  TextField searchByRef() {
    return TextField(
      controller: searchController,
      onTap: OrderListViewState().search(searchController),
      style: const TextStyle(color: Palette.text, fontSize: 20),
      onChanged: runFilter2,
      decoration: const InputDecoration(
          hintText: "Search By Ref. No.",
          prefixIcon: Icon(Icons.search),
          hintStyle: TextStyle(
              color: Color.fromRGBO(105, 105, 105, 0.5), fontSize: 20),
          labelStyle: TextStyle(
            fontSize: 20,
          ),
          filled: true,
          fillColor: Colors.white70,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(9)))),
    );
  }

  Future<List<OrderDetail>> getOrderData() async {
    try {
      final response = await orderService.getScreenOnLoad();
      return response;
    } catch (error) {
      rethrow;
    }
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

  buildDataTable(int index) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OrderSummeryPage(refNo: filteredOrders[index].refNo)));
      },
      title: DataTable(
        columns: [
          DataColumn(
              label: Text(
            'Ref no.:${filteredOrders[index].refNo.toString()}',
            style: const TextStyle(fontSize: 17),
          )),
          DataColumn(
              label: Text(
            filteredOrders[index].status.toString(),
            style: TextStyle(
                fontSize: 17,
                color: (filteredOrders[index].status == 'Assigned')
                    ? Colors.green
                    : (filteredOrders[index].status == 'Confirmed')
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
              '${filteredOrders[index].formatedDueDate.toString()}',
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
              '${filteredOrders[index].itemName.toString()}',
              style: TextStyle(
                fontSize: 17,
              ),
            ))
          ])
        ],
      ),
    );
  }

  @override
  void initState() {
    var response = orderService.getScreenOnLoad();
    response.then((value) {
      orderDetails.addAll(value);
      filteredOrders.addAll(value);
      runFilter2("");
    });
  }

  runFilter2(String enteredKeyword) {
    results;
    if (enteredKeyword.isEmpty) {
      results = orderDetails;
    } else {
      results = orderDetails.where((element) {
        var resultRefNo = element.refNo;
        return resultRefNo!.contains(enteredKeyword);
      }).toList();
    }
    setState(() {
      filteredOrders = results;
    });
  }
}
