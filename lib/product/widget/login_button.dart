import 'package:firebase_ugraslarim/core/widget/special_button.dart';
import 'package:firebase_ugraslarim/feature/pages/email_password_login_view.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  final String title = 'Email ile giriş yap';

  @override
  Widget build(BuildContext context) {
    return SpecialButton(
        buttonText: title,
        buttonColor: Colors.deepPurple,
        buttonTextColor: Colors.black,
        isCircle: false,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
              builder: ((context) => const EmailPasswordLoginView())));
        });
  }
}
