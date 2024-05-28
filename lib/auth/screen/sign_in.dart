import 'package:basicfirebase/auth/screen/sign_up.dart';
import 'package:basicfirebase/common/constant.dart';
import 'package:basicfirebase/common/logo.dart';
import 'package:basicfirebase/common/password_field.dart';
import 'package:basicfirebase/common/text_form_field.dart';
import 'package:basicfirebase/common/title.dart';
import 'package:basicfirebase/repository/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/no_animation_route_button.dart';
import '../../consumer/screen/main.dart';

class SignIn extends StatelessWidget {

  late final FirebaseAuth _authentication;

  String userEmail = '';
  String userPassword = '';

  SignIn({super.key});

  void _setInstance(BuildContext context) {
    _authentication = context.read<FirebaseRepository>().firebaseAuth;
  }

  @override
  Widget build(BuildContext context) {

    _setInstance(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              const MyLogo(size: 90),
              const SizedBox(height: 10,),
              const MyTitle(fontSize: 50),
              const SizedBox(height: 40,),
              MyTextFormField(
                  onSaved: (value) {
                    userEmail = value!;
                  },
                  onChanged: (value) {
                    userEmail = value!;
                  },
                  content: "이메일",
                  keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20,),
              PasswordField(
                  onSaved: (value) {
                    userPassword = value!;
                  },
                  onChanged: (value) {
                    userPassword = value!;
                  }
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constant.COLOR,
                    ),
                    onPressed: () async {
                      try {
                        final UserCredential newUser =
                        await _authentication.signInWithEmailAndPassword(
                            email: userEmail, password: userPassword);

                        if (newUser.user != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            NoAnimationRouteBuilder(builder: (context) => ConsumerMain()), (route) => false,
                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("이메일과 비밀번호를 확인하세요."),
                          backgroundColor: Colors.blue,
                        ));
                      }
                    },
                    child: const Text("로그인", style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constant.COLOR,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            NoAnimationRouteBuilder(builder: (context) => SignUp())
                        );
                      },
                      child: const Text("회원가입", style: TextStyle(color: Colors.white),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
