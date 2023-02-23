import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:order_mgmt_flutter/src/cubit/cubit.dart';

class OrderSummeryReader extends StatefulWidget {
  var refNo;
   OrderSummeryReader(this.refNo, {Key? key}) : super(key: key);

  @override
  State<OrderSummeryReader> createState() => _OrderSummeryReaderState();
}

class _OrderSummeryReaderState extends State<OrderSummeryReader> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        
        child: Column(children: [blockBuilder()],));
  }

  BlocBuilder<OrderSummeryCubit, OrderSummeryState> blockBuilder() {
    return BlocBuilder<OrderSummeryCubit, OrderSummeryState>(
      builder: (context, state) {
        if (state is OrderSummeryInitial || state is LoadingOrderSummeryState) {
          return const Center(child: CircularProgressIndicator());
        } //GetScreenLoadInitial, LoadingScreenLoadState
        else if (state is ResponseOrderSummeryState) {

          final orderSummery = state.orderSummery;
          return Padding(
            padding: const EdgeInsets.only(top: 30,left: 8,right: 8,bottom: 30),
            child: Container(
              height: MediaQuery.of(context).size.height/1.4,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 4,
                shadowColor: Colors.grey,

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: DataTable(
                          columns: [
                            DataColumn(
                                label: Text(
                                  'Status',
                                  style: const TextStyle(fontSize: 17,),
                                )),
                            DataColumn(
                                label: Text(
                                  "${orderSummery.status}",
                                  style:  TextStyle(fontSize: 17,color:(orderSummery.status=='Assigned')?Colors.green:(orderSummery.status=='Confirmed')?Colors.green:Colors.red ),
                                )),
                          ],

                          rows: [
                          DataRow(cells: [
                            DataCell(
                              Text(
                               ' Customer Name:',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                             DataCell(Text(
                              ' ${orderSummery.custName} ',
                              style: TextStyle(fontSize: 17,),
                            ))
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              'Stamp : ',
                              style: TextStyle(fontSize: 17,),
                            )),

              DataCell(Text(
                  '${orderSummery.stamp}',
                  style: TextStyle(fontSize: 17,),
              )),
                            ]),
                          DataRow(cells: [

                            DataCell(
                              Text(
                                'Item Name :',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${orderSummery.itemName.toString()}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),

                          ]),
                            DataRow(cells: [

                              DataCell(
                                Text(
                                  'Item Size : ',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${orderSummery.itemSize.toString()}',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ]),
                            DataRow(cells: [

                               DataCell(Text(
                                'Melt % : ',
                                style: TextStyle(fontSize: 17,),
                              )),
                              DataCell(Text(
                                '${orderSummery.meltPer.toString()}',
                                style: TextStyle(fontSize: 17,),
                              ))
                            ]),
                          DataRow(cells: [

                            DataCell(
                              Text(
                                'Order Type : ',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${orderSummery.type.toString()}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),


                            ]),
                          DataRow(cells: [
                            DataCell(
                              Text(
                                'Hook :',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${orderSummery.hook.toString()}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),

                            ]),
                          DataRow(cells: [
                            DataCell(Text(
                              'Ref. Code : ',
                              style: TextStyle(fontSize: 17,),
                            )),
                            DataCell(Text(
                              ' ${orderSummery.refNo.toString()}',
                              style: TextStyle(fontSize: 17,),
                            ))

                            ]),
                          DataRow(cells: [
                            DataCell(
                              Text(
                                'Design Sample : ',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${orderSummery.designSample.toString()}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),

                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                'Size Sample :',
                                style: TextStyle(fontSize: 17,),
                              )),
                              DataCell(Text(
                                '${orderSummery.sizeSample.toString()}',
                                style: TextStyle(fontSize: 17,),
                              ))

                            ]),
                            DataRow(cells: [
                              DataCell(
                                Text(
                                  'Total Days :',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              DataCell(
                                Text(
                                  ' ${orderSummery.days.toString()}',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),

                            ]),
                            DataRow(cells: [
                              DataCell(
                                Text(
                                  'Due Date :',
                                  style: TextStyle(fontSize: 17,),
                                )),
                              DataCell(
                                  Text(
                                    '${orderSummery.dueDate.toString()}',
                                    style: TextStyle(fontSize: 17,),
                                  )),

                            ]),
                            DataRow(cells: [
                              DataCell(
                                Text(
                                  'Workshop : ',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${(orderSummery.workshop=="null")?"Not Assigned":orderSummery.workshop.toString()}',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),

                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                'Order Date :',
                                style: TextStyle(fontSize: 17,),
                              )),
                              DataCell(Text(
                                ' ${orderSummery.orderDate.toString()}',
                                style: TextStyle(fontSize: 17,),
                              )),

                            ]),
                        ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),
          );
        } //ResponseScreenLoadState
        else if (state is ErrorOrderSummeryState) {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<OrderSummeryCubit>();
      cubit.loadOrderSummery(widget.refNo);
      print("${widget.refNo}======>");
    });
  }
}
