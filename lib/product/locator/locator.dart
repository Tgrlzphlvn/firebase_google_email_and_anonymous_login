import 'package:firebase_ugraslarim/feature/service/auth_service.dart';
import 'package:firebase_ugraslarim/feature/service/fake_auth_service.dart';
import 'package:firebase_ugraslarim/product/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();


void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => UserRepository());
}
