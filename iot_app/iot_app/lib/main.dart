import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/firebase_options.dart';
import 'package:iot_app/pages/models/bin_list.dart';
import 'package:provider/provider.dart';
import 'package:iot_app/pages/login.dart';
import 'pages/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
    
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  firebaseAppCheck.activate(
    androidProvider: AndroidProvider.debug,
  );
  firebaseAppCheck.getToken().then((value) => print("APP CHECK: $value"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BinList(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    FirebaseAuth auth = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth.currentUser == null
          ? const LoginPage()
          : const IntroPage(),
    );
  }
}
  