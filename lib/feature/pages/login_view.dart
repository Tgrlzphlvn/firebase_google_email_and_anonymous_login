import 'package:firebase_ugraslarim/feature/model/user_model.dart';
import 'package:firebase_ugraslarim/feature/viewmodel/user_view_model.dart';
import 'package:firebase_ugraslarim/product/widget/google_button.dart';
import 'package:firebase_ugraslarim/product/widget/login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widget/special_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  final String title = 'Giriş Yap';
  final String signInTitle = 'Misafir oturum aç';

  @override
  Widget build(BuildContext context) {
    final _userModelViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginButton(),
            GoogleButton(onPressed: () {
              return _googleWithSignIn(context);
            }),
            _anonymousLoginButton(context)
          ],
        ),
      ),
    );
  }

  Widget _anonymousLoginButton(BuildContext context) {
    return SpecialButton(
        buttonText: signInTitle,
        buttonColor: Colors.grey,
        isCircle: false,
        buttonTextColor: Colors.white,
        onPressed: () {
          _anonymousLogin(context);
        });
  }

  void _anonymousLogin(BuildContext context) async {
    final _userModelViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    UserModel? _userModel = await _userModelViewModel.signInAnonymously();
    debugPrint(_userModel!.userId);
  }

  void _googleWithSignIn(BuildContext context) async {
    final _userModelViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    UserModel? _userModel = await _userModelViewModel.signInWithGoogle();
    debugPrint(_userModel!.userId);
  }
}
