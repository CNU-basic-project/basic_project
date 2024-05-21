import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String> onChanged;
  final String content;
  final TextInputType keyboardType;

  const MyTextFormField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    required this.content,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        onSaved: onSaved,
        onChanged: onChanged,
        decoration: InputDecoration(
            labelText: content,
            hintText: content,
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
            )
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
