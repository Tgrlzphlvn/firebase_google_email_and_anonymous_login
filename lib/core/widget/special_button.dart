import 'package:flutter/material.dart';

class SpecialButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  Color? buttonTextColor;
  final bool isCircle;
  IconData? butonIcon;
  final VoidCallback onPressed;

  SpecialButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.buttonTextColor,
    required this.isCircle,
    this.butonIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(buttonText),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(_sizeWidth(context), _sizeHeight(context)),
          shape: isCircle ? const CircleBorder() : const StadiumBorder(),
          primary: buttonColor,
          textStyle: TextStyle(
            color: buttonTextColor ?? Colors.white,
          ),
        ),
      ),
    );
  }

  double _sizeWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / 1.5;
  }

  double _sizeHeight(BuildContext context) {
    return MediaQuery.of(context).size.height / 20;
  }
}
