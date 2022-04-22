import 'package:elearningteacher2/page/home_page.dart';
import 'package:elearningteacher2/page/sign_in_sign_up/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    print("Connect Firebase Success");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-learning Teacher',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          color: Colors.orangeAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orangeAccent,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xffFF1493),
          selectionColor: Color(0xffFF69B4),
          selectionHandleColor: Color(0xffFF69B4),
        ),
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // return const SignInPage();
          return const SignInPage();
        } else {
          String sUID = snapshot.data!.uid;
          return HomePage(sUID: sUID);
        }
      },
    );
  }
}