import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {

  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String> onChanged;
  final String hint;

  const PasswordField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    this.hint = "비밀번호를 입력하세요"
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passwordVisible=true;

  // @override
  // void initState(){
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        obscureText: passwordVisible,
        decoration: InputDecoration(
            labelText: "비밀번호",
            hintText: widget.hint,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.deepPurpleAccent),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.blueAccent),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            suffixIcon: IconButton(
              icon: Icon(passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                setState(
                      () {
                    passwordVisible = !passwordVisible;
                  },
                );
              },
            ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
