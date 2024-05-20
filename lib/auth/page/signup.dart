import 'package:basicfirebase/common/appbar.dart';
import 'package:basicfirebase/common/logo.dart';
import 'package:basicfirebase/common/password_field.dart';
import 'package:basicfirebase/common/title.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              const MyLogo(size: 90),
              const SizedBox(height: 10,),
              const MyTitle(fontSize: 50),
              const SizedBox(height: 80,),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "아이디",
                      hintText: "아이디를 입력하세요",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.deepPurpleAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 60,),
              PasswordField(),
              const SizedBox(height: 60,),
              ElevatedButton(
                  onPressed: (){
                    print("pressed");
                    },
                  child: const Text("로그인"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
