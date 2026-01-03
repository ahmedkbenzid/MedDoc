import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';

import '../../consts/colors.dart';

class CustumTextfield extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blueColor,
      controller: textController,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: borderColor,
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: borderColor,
          )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: borderColor,
          )),
          hintText: hint,
          hintStyle: TextStyle(
            color: textColor,
          )),
    );
  }
}