import 'package:basicfirebase/auth/screen/sign_in.dart';
import 'package:basicfirebase/consumer/screen/main.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:basicfirebase/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      Provider<TokenProvider>(
        create: (context) => TokenProvider(token: '', authService: AuthService()),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Main()
      ),
    ),
  ));
}


class Main extends StatelessWidget {
  Main({super.key});

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
