import 'package:firebase_ugraslarim/feature/pages/login_view.dart';
import 'package:firebase_ugraslarim/feature/view/home_view.dart';
import 'package:firebase_ugraslarim/feature/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userModelViewModel = Provider.of<UserViewModel>(context);


    if(_userModelViewModel.state == ViewState.idle){
      if(_userModelViewModel.userModel == null) {
        return const LoginView();
      } else {
        return HomeView(user: _userModelViewModel.userModel!);
      }

    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
