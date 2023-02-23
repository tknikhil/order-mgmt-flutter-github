part of 'order_summery_cubit.dart';

abstract class OrderSummeryState {}

class OrderSummeryInitial extends OrderSummeryState {}

class LoadingOrderSummeryState extends OrderSummeryState{}
class ErrorOrderSummeryState extends OrderSummeryState{
  final String message;
  ErrorOrderSummeryState(this.message);
}
class ResponseOrderSummeryState extends OrderSummeryState{
  final OrderSummery orderSummery;
  ResponseOrderSummeryState(this.orderSummery);
}

