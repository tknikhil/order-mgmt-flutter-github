part of 'item_name_cubit.dart';

@immutable
abstract class ItemNameState {}

class ItemNameInitial extends ItemNameState {}

class LoadingItemNameState extends ItemNameState{}
class ResponseItemNameState extends ItemNameState{
   List<ItemName> itemName;
  ResponseItemNameState(this.itemName);
}
class ErrorItemNameState extends ItemNameState{
  String message;
  ErrorItemNameState(this.message);
}
