import 'package:firebase_ugraslarim/feature/model/user_model.dart';
import 'package:firebase_ugraslarim/feature/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key,  required this.user}): super(key: key);

  final UserModel user;


  final String title = 'Hoşgeldin ';
  final String _buttonTitle = 'Çıkış Yap';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.userId ?? 'Burası boş :('),
            _exitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _exitButton(BuildContext context) {
    return TextButton(
      child: Text(_buttonTitle),
      onPressed: () {
        _exit(context);
      },
    );
  }

  Future<bool?> _exit(BuildContext context) async {
    final _userModelViewModel = Provider.of<UserViewModel>(context,listen: false);

    bool? result = await _userModelViewModel.signOut();
    return result;
  }
}
