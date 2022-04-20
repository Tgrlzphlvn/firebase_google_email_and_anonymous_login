import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ugraslarim/feature/model/user_model.dart';
import 'package:firebase_ugraslarim/feature/service/fake_auth_service.dart';
import 'package:firebase_ugraslarim/feature/service/i_auth_service.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// Firebase User modelini kendi UserModel'imize döndürüyoruz
  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return UserModel(userId: null);
    }
    return UserModel(userId: user.uid);
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return _userFromFirebase(user!);
    } catch (e) {
      debugPrint('Current user has not found: $e');
      return FakeAuthService().currentUser();
    }
  }

  @override
  Future<UserModel> signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(userCredential.user!);
    } catch (e) {
      debugPrint('Anonymous login has failed: $e');
      return FakeAuthService().signInAnonymously();
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.signOut();
        await _firebaseAuth.signOut();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Sign Out is Failed: $e');
      return false;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        User user = userCredential.user!;
        return _userFromFirebase(user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signInEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user!);
    } catch (e) {
      debugPrint('Sign in is failed: ' + e.toString());
      return FakeAuthService().signInEmailandPassword(email, password);
    }
  }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user!);
    } catch (e) {
      debugPrint('Sign in is failed: ' + e.toString());
      return FakeAuthService().createUserWithEmailAndPassword(email, password);
    }
  }
}
