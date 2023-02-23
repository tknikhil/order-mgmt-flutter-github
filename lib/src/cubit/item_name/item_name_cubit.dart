import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:order_mgmt_flutter/src/model/model.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';

part 'item_name_state.dart';

class ItemNameCubit extends Cubit<ItemNameState> {
  final AddItemService addItemService;

  ItemNameCubit(this.addItemService) : super(ItemNameInitial());

  Future<List<ItemName>> loadItemService() async {
    emit(LoadingItemNameState());
    //when gets response
    try {
      final response = await addItemService.addItemNameLoad();
      emit(ResponseItemNameState(response));
      return response;
    } catch (error) {
      emit(ErrorItemNameState(error.toString()));
      rethrow;
    }
  }
}
