import 'package:firebase_ugraslarim/feature/model/user_model.dart';
import 'package:firebase_ugraslarim/feature/service/auth_service.dart';
import 'package:firebase_ugraslarim/feature/service/fake_auth_service.dart';
import 'package:firebase_ugraslarim/feature/service/i_auth_service.dart';
import 'package:firebase_ugraslarim/product/locator/locator.dart';

enum AppMode { debug, release }

class UserRepository implements IAuthService {
  final AuthService _authService = locator<AuthService>();
  final FakeAuthService _fakeAuthService = locator<FakeAuthService>();

  AppMode appMode = AppMode.release;

  @override
  Future<UserModel> currentUser() async {
    if (appMode == AppMode.debug) {
      return await _fakeAuthService.currentUser();
    } else {
      return await _authService.currentUser();
    }
  }

  @override
  Future<UserModel> signInAnonymously() async {
    if (appMode == AppMode.debug) {
      return await _fakeAuthService.signInAnonymously();
    } else {
      return await _authService.signInAnonymously();
    }
  }

  @override
  Future<bool?> signOut() async {
    if (appMode == AppMode.debug) {
      return await _fakeAuthService.signOut();
    } else {
      return await _authService.signOut();
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    if (appMode == AppMode.debug) {
      return await _fakeAuthService.signInWithGoogle();
    } else {
      return await _authService.signInWithGoogle();
    }
  }

  @override
  Future<UserModel?> signInEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.debug) {
      return await _fakeAuthService.signInEmailandPassword(email, password);
    } else {
      return await _authService.signInEmailandPassword(email, password);
    }
  }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password) async {
    if (appMode == AppMode.debug) {
      return await _fakeAuthService.createUserWithEmailAndPassword(
          email, password);
    } else {
      return await _authService.createUserWithEmailAndPassword(email, password);
    }
  }
}
