import 'package:firebase_ugraslarim/core/widget/special_button.dart';
import 'package:firebase_ugraslarim/feature/model/user_model.dart';
import 'package:firebase_ugraslarim/feature/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FormType { register, login }

class EmailPasswordLoginView extends StatefulWidget {
  const EmailPasswordLoginView({Key? key}) : super(key: key);

  @override
  State<EmailPasswordLoginView> createState() => _EmailPasswordLoginViewState();
}

class _EmailPasswordLoginViewState extends State<EmailPasswordLoginView> {
  bool _isObscure = false;
  String? _email, _password;
  String? _buttonText, _linkText;

  final _fromKey = GlobalKey<FormState>();

  FormType _formType = FormType.login;

  void _changeInputType() {
    setState(() {
      _formType =
          _formType == FormType.login ? FormType.register : FormType.login;
    });
  }

  void _formSubmit() async {
    _fromKey.currentState!.save();
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if (_formType == FormType.login) {
      UserModel? _signInUser = await _userViewModel.signInEmailandPassword(
          _email.toString(), _password.toString());
      if (_signInUser != null) {
        debugPrint('Sign in user: ${_signInUser.userId}');
        Navigator.of(context).pop();
      }
    } else {
      UserModel? _registredUser =
          await _userViewModel.createUserWithEmailAndPassword(
              _email.toString(), _password.toString());
      if (_registredUser != null) {
        debugPrint('Sign in user: ${_registredUser.userId}');
        Navigator.of(context).pop();
      }
    }
  }

  void _changeObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    _changeObscure();
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.login ? 'Giriş Yap' : 'Kaydol';
    _linkText = _formType == FormType.login
        ? 'Hesabınız yok mu? Kaydol.'
        : 'Hesabınız var mı? Giriş yapın.';

    final _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: _userViewModel.state == ViewState.idle
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                  right: 20,
                  left: 20,
                ),
                child: Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      _emailInput(),
                      _passwordInput(),
                      _loginButton(),
                      _isLoginOrSignIn(),
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  TextFormField _emailInput() {
    final _userViewModel = Provider.of<UserViewModel>(context);

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: _userViewModel.emailFailedMessage != null
            ? _userViewModel.emailFailedMessage
            : null,
        prefixIcon: const Icon(Icons.mail),
        hintText: 'Email',
        labelText: 'Email',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      onSaved: (email) {
        _email = email;
      },
    );
  }

  Widget _passwordInput() {
    final _userViewModel = Provider.of<UserViewModel>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        obscureText: _isObscure,
        decoration: InputDecoration(
          errorText: _userViewModel.passwordFailedMessage != null
              ? _userViewModel.passwordFailedMessage
              : null,
          suffixIcon: IconButton(
              onPressed: () {
                _changeObscure();
              },
              icon: _isObscure
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
          prefixIcon: const Icon(Icons.key),
          hintText: 'Email',
          labelText: 'Email',
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        onSaved: (password) {
          _password = password;
        },
      ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SpecialButton(
          buttonText: _buttonText.toString(),
          buttonColor: Colors.deepPurple,
          isCircle: false,
          onPressed: () {
            _formSubmit();
          }),
    );
  }

  TextButton _isLoginOrSignIn() {
    return TextButton(
      child: Text(_linkText.toString()),
      onPressed: () => _changeInputType(),
    );
  }
}
