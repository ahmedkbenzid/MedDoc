import 'package:flutter_application_1/consts/consts.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const CustomButton({super.key,required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    width: context.screenWidth,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      onPressed: onTap, 
                     child: buttonText.text.make(),),
                  );
  }
}