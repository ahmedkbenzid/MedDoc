import 'package:flutter_application_1/consts/consts.dart';
class CustumTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController? textController;
  final Color textColor;
  final Color borderColor;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Function(String)? onChanged;
  
  const CustumTextfield({
    super.key,
    required this.hint,
    this.textController,
    this. textColor = Colors.black,
    this.borderColor = Colors. black,
    this.validator,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blueColor,
      controller: textController,
      validator: validator,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(
            color:  borderColor,
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