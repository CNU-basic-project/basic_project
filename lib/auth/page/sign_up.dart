import 'package:basicfirebase/common/logo.dart';
import 'package:basicfirebase/common/no_animation_route_button.dart';
import 'package:basicfirebase/common/password_field.dart';
import 'package:basicfirebase/common/text_form_field.dart';
import 'package:basicfirebase/common/title.dart';
import 'package:basicfirebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/constant.dart';

class SignUp extends StatelessWidget {
  final _authentication = FirebaseAuth.instance;

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userPasswordCheck = '';

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const MyLogo(size: 90),
              const SizedBox(
                height: 10,
              ),
              const MyTitle(fontSize: 50),
              const SizedBox(
                height: 40,
              ),
              MyTextFormField(
                // ID Form Field
                onSaved: (value) {
                  userName = value!;
                },
                onChanged: (value) {
                  userName = value!;
                },
                content: "아이디",
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextFormField(
                // Email Form Field
                onSaved: (value) {
                  userEmail = value!;
                },
                onChanged: (value) {
                  userEmail = value!;
                },
                content: "이메일",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordField(// PW Form Field
                  onSaved: (value) {
                userPassword = value!;
              }, onChanged: (value) {
                userPassword = value!;
              }),
              const SizedBox(
                height: 20,
              ),
              PasswordField(
                // PW Check Form Field
                onSaved: (value) {
                  userPasswordCheck = value!;
                },
                onChanged: (value) {
                  userPasswordCheck = value!;
                },
                hint: "비밀번호 (확인)",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constant.COLOR,
                ),
                onPressed: () async {
                  try {
                    final UserCredential newUser =
                        await _authentication.createUserWithEmailAndPassword(
                            email: userEmail, password: userPassword);

                    if (newUser.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          NoAnimationRouteBuilder(builder: (context) => MyHomePage(title: 'Firebase Analytics Event', analytics: MyApp.analytics)), (route) => false,
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
                child: const Text("회원가입", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
