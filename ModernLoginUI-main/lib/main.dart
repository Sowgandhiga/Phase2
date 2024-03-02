import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/authmail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modernlogintute/pages/homepage.dart';
import 'package:modernlogintute/pages/otp.dart';
import 'package:modernlogintute/pages/phonepage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthMail(),
      routes: {
        'phonepage': (context) => PhonePage(),
        'otp': (context) => Otp(),
        'home': (context) => HomePage(),
      },
    );
  }
}
