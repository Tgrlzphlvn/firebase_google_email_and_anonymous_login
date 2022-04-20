import 'package:firebase_ugraslarim/feature/model/user_model.dart';
import 'package:firebase_ugraslarim/feature/service/i_auth_service.dart';

class FakeAuthService extends IAuthService {
  String fakeUserId = 'Fake user id 31';
  @override
  Future<UserModel> currentUser() async {
    return await Future.value(UserModel(userId: fakeUserId));
  }

  @override
  Future<UserModel> signInAnonymously() async {
    return await Future.delayed(
        const Duration(seconds: 2), () => UserModel(userId: fakeUserId));
  }

  @override
  Future<bool> signOut() async {
    return Future.value(true);
  }

  @override
  Future<UserModel?> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInEmailandPassword(String email, String password) {
    // TODO: implement signInEmailandPassword
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }
}
