
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

abstract class IAuthService {
  Future<UserModel?> currentUser();

  Future<UserModel?> signInAnonymously();

  Future<UserModel?> signInEmailandPassword(String email, String password);

  Future<UserModel?> createUserWithEmailAndPassword(String email, String password);

  Future<UserModel?> signInWithGoogle();

  Future<bool?> signOut();
}
