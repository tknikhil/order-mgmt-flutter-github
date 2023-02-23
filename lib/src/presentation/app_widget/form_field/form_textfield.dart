import 'package:flutter/material.dart';

import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class FormTextField extends StatefulWidget {
  final TextEditingController inputController;
  final String label;

  FormTextField({
    Key? key,
    required this.inputController,
    required this.label,
  }) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  TextEditingController get inputController2 => widget.inputController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inputController,
      validator: (value) {
        if (value!.isEmpty) {
          return "please enter your ${widget.label} !";
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 20,
        color: Palette.text,
      ),
      decoration: InputDecoration(
          labelText: widget.label,
          hintText: "Please enter your ${widget.label} ",
          hintStyle: const TextStyle(color: Color.fromRGBO(105, 105, 105, 0.5)),
          labelStyle: const TextStyle(
            fontSize: 25,
            color: Palette.text,
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Palette.gold),
              borderRadius: BorderRadius.all(Radius.circular(9))),
          filled: true,
          fillColor: Colors.white24,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(9)))),
    );
  }
}
