import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socratea/screens/login_screen.dart';
import 'package:socratea/screens/signup_screen.dart';
import 'package:socratea/utils/colors.dart';
import 'package:socratea/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sample',
        theme: ThemeData.light().copyWith(

      scaffoldBackgroundColor: mobileColor,
    ),
        home: LoginScreen(),
    );
  }
}

