import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socratea/providers/user_provider.dart';
import 'package:socratea/responsive/mobile_screen.dart';
import 'package:socratea/screens/ProfileScreen.dart';
import 'package:socratea/screens/login_screen.dart';
import 'package:socratea/screens/signup_screen.dart';
import 'package:socratea/utils/colors.dart';
import 'package:socratea/utils/styles.dart';
import 'package:socratea/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sample',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return  MobileScreenLayout(uid: FirebaseAuth.instance.currentUser!.uid);
                } else if (snapshot.hasError) {
                  return showSnackBar(context, '${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
                return LoginScreen();

            }),
      ),
    );
  }
}
