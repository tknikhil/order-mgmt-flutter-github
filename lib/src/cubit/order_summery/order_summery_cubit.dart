import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:order_mgmt_flutter/src/model/model.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';

part 'order_summery_state.dart';

class OrderSummeryCubit extends Cubit<OrderSummeryState> {
  final OrderSummeryService orderSummerySevice;
  OrderSummeryCubit(this.orderSummerySevice
      ):super(OrderSummeryInitial());

  //when ever this method call it emits LoadingScreenLoadState()
  Future<void> loadOrderSummery(refNo)async{
    emit(LoadingOrderSummeryState());
    //when gets response
    try{
      print('${orderSummerySevice.getOrderDetail(refNo)} ==================from cubit');
      final response=await orderSummerySevice.getOrderDetail(refNo);
      print('${response.itemUnit} ==================from loadOrderSummery');
      emit(ResponseOrderSummeryState(response));
      // return response;
    }catch(error){
      emit(ErrorOrderSummeryState(error.toString()));
      rethrow;
    }
  }
}
