import 'package:basicfirebase/auth/screen/sign_in.dart';
import 'package:basicfirebase/common/logo.dart';
import 'package:basicfirebase/common/no_animation_route_button.dart';
import 'package:basicfirebase/common/password_field.dart';
import 'package:basicfirebase/common/text_form_field.dart';
import 'package:basicfirebase/common/title.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common/constant.dart';
import '../../consumer/screen/main.dart';

class SignUp extends StatelessWidget {

  late TokenProvider tokenProvider;

  String name = '';
  String username = '';
  String userPassword = '';
  String userPasswordCheck = '';

  SignUp({super.key});

  void _setInstance(BuildContext context) {
    tokenProvider = context.read<TokenProvider>();
  }

  bool _validate() {
    if (userPassword == userPasswordCheck) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {

    _setInstance(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
                  name = value!;
                },
                onChanged: (value) {
                  name = value!;
                },
                content: "닉네임",
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextFormField(
                // Email Form Field
                onSaved: (value) {
                  username = value!;
                },
                onChanged: (value) {
                  username = value!;
                },
                content: "아이디",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constant.COLOR,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            NoAnimationRouteBuilder(builder: (context) => SignIn())
                        );
                      },
                      child: const Text("로그인", style: TextStyle(color: Colors.white),)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constant.COLOR,
                    ),
                    onPressed: () async {
                      try {
                        if (!_validate()) throw Exception();

                        await tokenProvider.signUp(name, username, userPassword);

                        if (tokenProvider.token != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              NoAnimationRouteBuilder(builder: (context) => SignIn()), (route) => false,
                          );
                          showDialog(context: context, builder: (builder) {
                            return AlertDialog(
                              content: Text("회원가입이 완료됐습니다."),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(builder);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Constant.COLOR
                                    ),
                                    child: const Center(
                                        child: Text("확인", style: TextStyle(color: Colors.white),)
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                        }
                        throw Exception();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("아이디와 비밀번호를 확인하세요."),
                          backgroundColor: Colors.blue,
                        ));
                      }
                    },
                    child: const Text("회원가입", style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
