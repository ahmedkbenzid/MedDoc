import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';

import '../../consts/colors.dart';

class CustumTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController? textController;
  final Color textColor;
  final Color borderColor;
  const CustumTextfield({super.key, required this.hint, this.textController, this.textColor= Colors.black, this.borderColor=Colors.black});

  @override
  State<CustumTextfield> createState() => _CustumTextfieldState();
}

class _CustumTextfieldState extends State<CustumTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blueColor,
      decoration: InputDecoration(
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
          )
        ),
        border:OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor
          )
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.textColor,
        )
      ),
    );
  }
}