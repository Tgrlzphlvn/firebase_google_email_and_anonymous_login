import 'package:firebase_ugraslarim/core/widget/special_button.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function() onPressed;
  final String title = 'Google ile oturum aç';


  @override
  Widget build(BuildContext context) {
    return SpecialButton(
        buttonText: title,
        buttonColor: Colors.red,
        buttonTextColor: Colors.white,
        isCircle: false,
        onPressed: onPressed);
  }
}
