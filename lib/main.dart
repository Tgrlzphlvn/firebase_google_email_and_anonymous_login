import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ugraslarim/feature/pages/landing_page.dart';
import 'package:firebase_ugraslarim/feature/viewmodel/user_view_model.dart';
import 'package:firebase_ugraslarim/product/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
