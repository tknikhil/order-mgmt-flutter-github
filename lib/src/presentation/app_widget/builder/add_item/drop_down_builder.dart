import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:order_mgmt_flutter/src/cubit/cubit.dart';
import 'package:order_mgmt_flutter/src/model/model.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class DropDownBuilder extends StatefulWidget {
  var cnt;
   DropDownBuilder({
    Key? key,
     required final cnt,
  }) : super(key: key);
   var itemname;

  @override
  State<DropDownBuilder> createState() => DropDownBuilderState();

}

class DropDownBuilderState extends State<DropDownBuilder> {
   List<ItemName> items = [];
   bool clearVal=true;
  FocusNode? textFieldFocusNode = FocusNode();
   FormFieldValidator<String> validator  = (value)=> value!.isEmpty?'required':null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemNameCubit, ItemNameState>(
      builder: (context, state) {
        if (state is ResponseItemNameState) {
          items = state.itemName;
          final itemval = items
              .map((e) => DropDownValueModel(name: e.label, value: e.value))
              .toList();
          return SizedBox(
            child: DropDownTextField(
              textFieldDecoration:  const InputDecoration(
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Palette.gold),
                    borderRadius: BorderRadius.all(Radius.circular(9))),
                focusedErrorBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(9))),
                label: Text("Select Item"),
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Palette.text,
                ),
                hintStyle:
                    TextStyle(color: Color.fromRGBO(105, 105, 105, 0.5)),
                enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Palette.gold),
                    borderRadius: BorderRadius.all(Radius.circular(9))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.gold),
                    borderRadius: BorderRadius.all(Radius.circular(9))),
              ),

              controller: cnt,
              textFieldFocusNode: textFieldFocusNode,
               clearOption: clearVal,
              keyboardType: TextInputType.text,
              enableSearch: true,
              searchDecoration:
                  const InputDecoration(hintText: "Search Item Name"),
              dropdownColor: Color(0xffffbf1de),
              textStyle: const TextStyle(color: Palette.text),
              dropDownItemCount: 6,
               validator: validator,
              dropDownList: itemval!,
              onChanged: (val) {
                setState(() {
                  widget.itemname = val.name;
                });
              },
            ),
          );
        } else {
          return FormAddItemTextField.unEditable(
              inputController: itemNameController, label: "Unable to find Item!", boolval: false,mxLine: 1,);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context?.read<ItemNameCubit>();
      cubit?.loadItemService();

      cubit?.loadItemService().then((value) => items = value!);
    });
  }

   @override
  void dispose() {
     textFieldFocusNode?.dispose();
     super.dispose();
  }

}
