import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';

import '../../consts/colors.dart';

class CustumTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController? textController;
  final Color textColor;
  final Color borderColor;
  final String? Function(String?)? validator;
  final bool obscureText;
  const CustumTextfield({
    super.key,
    required this.hint,
    this.textController,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.validator,
    this.obscureText = false,
  });

  @override
  State<CustumTextfield> createState() => _CustumTextfieldState();
}

class _CustumTextfieldState extends State<CustumTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blueColor,
      controller: widget.textController,
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: widget.borderColor,
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: widget.borderColor,
          )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: widget.borderColor,
          )),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: widget.textColor,
          )),
    );
  }
}