import 'dart:math';

import 'package:firebase_ugraslarim/feature/model/user_model.dart';
import 'package:firebase_ugraslarim/feature/service/i_auth_service.dart';
import 'package:firebase_ugraslarim/product/locator/locator.dart';
import 'package:firebase_ugraslarim/product/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';

enum ViewState { idle, busy }

class UserViewModel with ChangeNotifier implements IAuthService {
  String? emailFailedMessage;
  String? passwordFailedMessage;

  ViewState _state = ViewState.idle;

  final UserRepository _userRepository = locator<UserRepository>();

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      state = ViewState.busy;
      _userModel = await _userRepository.currentUser();
      return _userModel;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try {
      state = ViewState.busy;
      _userModel = await _userRepository.signInAnonymously();
      return _userModel;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      state = ViewState.busy;
      bool? _result = await _userRepository.signOut();
      _userModel = null;
      return _result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      state = ViewState.busy;
      _userModel = await _userRepository.signInWithGoogle();
      return _userModel;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> signInEmailandPassword(
      String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
        state = ViewState.busy;
        _userModel = await _userRepository.signInEmailandPassword(
            email, password);
        return _userModel;
      } else
        return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
        state = ViewState.busy;
        _userModel = await _userRepository.createUserWithEmailAndPassword(
            email, password);
        return _userModel;
      } else
        return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  bool _emailPasswordControl(String email, String password) {
    var result = true;

    if (password.length < 6) {
      passwordFailedMessage = 'Şifreniz en az 8 karakter olmalı!';
      result = false;
    } else
      passwordFailedMessage = null;
    if (!email.contains('@')) {
      emailFailedMessage = 'Lütfen gerçek bir mail adresi giriniz!';
      result = false;
    } else
      passwordFailedMessage = null;
    return result;
  }
}
