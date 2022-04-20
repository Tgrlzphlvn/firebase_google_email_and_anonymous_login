import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ugraslarim/core/widget/special_button.dart';
import 'package:flutter/material.dart';

class AnonymousButton extends StatelessWidget {
  const AnonymousButton({Key? key,required this.onSignIn}) : super(key: key);

  final String title = 'Misafir oturum aç';

  final Function(User) onSignIn;

  @override
  Widget build(BuildContext context) {
    return SpecialButton(
        buttonText: title,
        buttonColor: Colors.grey,
        isCircle: false,
        buttonTextColor: Colors.white,
        onPressed: () {
          _anonymousLogin();
        });
  }

  void _anonymousLogin() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    onSignIn(userCredential.user!);
    print(userCredential.user?.uid.toString() ?? ' veri yok ');
  }
}
