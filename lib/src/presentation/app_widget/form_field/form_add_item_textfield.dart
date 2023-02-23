import 'package:flutter/material.dart';

import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class FormAddItemTextField extends StatefulWidget {
  final TextEditingController inputController;
  final String label;
  var onChangeEvent;
  var boolval;
  var mxLine;
  var textType;
  var errorMessage;

  FormAddItemTextField.unEditable(
      {Key? key,
      required this.inputController,
      required this.label,
      required this.boolval,
      required this.mxLine})
      : super(key: key);

  FormAddItemTextField.withChangeEvent(
      {Key? key,
      required this.inputController,
      required this.label,
      required this.onChangeEvent,
      required this.mxLine,
      required this.textType})
      : super(key: key);

  FormAddItemTextField(
      {Key? key,
      required this.inputController,
      required this.label,
      required this.mxLine,
      required this.textType})
      : super(key: key);

  @override
  State<FormAddItemTextField> createState() => _FormAddItemTextFieldState();
}

class _FormAddItemTextFieldState extends State<FormAddItemTextField> {
  TextEditingController get inputController2 => widget.inputController;

  _FormAddItemTextFieldState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: widget.inputController,
        cursorHeight: 20,
        validator: (value) {
          if (value!.isEmpty) {
            return "required!";
          } else if (value == 'INVALID') {
            return "wrong Melt %";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.disabled,
        enabled: widget.boolval,
        keyboardType: widget.textType,
        onChanged: widget.onChangeEvent,
        maxLines: widget.mxLine,
        style: const TextStyle(
          fontSize: 15,
          color: Palette.text,
        ),
        decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.gold),
                borderRadius: BorderRadius.all(Radius.circular(9))),
            labelText: widget.label,
            hintText: "${widget.label} ",
            hintStyle: const TextStyle(
              color: Color.fromRGBO(105, 105, 105, 0.5),
            ),
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Palette.text,
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.gold),
                borderRadius: BorderRadius.all(Radius.circular(9))),
            filled: true,
            fillColor: Colors.white24,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)))),
      ),
    );
  }
}
