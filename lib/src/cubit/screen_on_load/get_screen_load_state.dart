part of 'get_screen_load_cubit.dart';


abstract class GetScreenLoadState {}

class GetScreenLoadInitial extends GetScreenLoadState {}

class LoadingScreenLoadState extends GetScreenLoadState{}

class ErrorScreenLoadState extends GetScreenLoadState{
  final String message;
  ErrorScreenLoadState(this.message);
}
class ResponseScreenLoadState extends GetScreenLoadState{
  final List<OrderDetail> orderDetial;
  ResponseScreenLoadState(this.orderDetial);
}
