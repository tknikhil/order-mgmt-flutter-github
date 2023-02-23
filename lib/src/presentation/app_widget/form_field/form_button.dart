import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormButton extends StatefulWidget {
  IconData? buttonIcon;
  final Color textcolor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  double heightSize;
  double widthSize;
  final VoidCallback onPressed;

  FormButton({
    Key? key,
    required this.onPressed,
    this.buttonIcon,
    required this.textcolor,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.heightSize,
    required this.widthSize,
  }) : super(key: key);

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  bool? isIcon;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightSize,
      width: widget.widthSize,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            side: BorderSide(width: 3, color: widget.borderColor),
            //border width and color
            elevation: 3,
            //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(2)),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.text,
                style: TextStyle(color: widget.textcolor, fontSize: 25)),
            // <-- Text
            const SizedBox(
              width: 5,
            ),
            Icon(
              // <-- Icon
              widget.buttonIcon,
              color: widget.textcolor,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
