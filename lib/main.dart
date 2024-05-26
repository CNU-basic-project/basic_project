import 'package:basicfirebase/auth/page/sign_in.dart';
import 'package:basicfirebase/auth/page/sign_up.dart';
import 'package:basicfirebase/consumer/page/main.dart';
import 'package:basicfirebase/consumer/widget/main_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'common/appbar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) loggedUser = user;
    } catch (e) {
      print("ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {

    getCurrentUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(
          child: loggedUser == null ? SignIn() : ConsumerMain(),
      )
        // SignIn()
    );
  }
}