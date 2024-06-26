import 'package:flutter/material.dart';

class InputData extends StatelessWidget {
  const InputData({
    super.key,
    required this.title,
    required this.onChanged,
    required this.text,
  });

  final String title, text;
  final Function(String) onChanged;

  MaterialStateProperty<Color?> getBackGroundColor() {
    return MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1);
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController controller = TextEditingController(text: text);

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              )),
          Expanded(
            flex: 2,
            child: SearchBar(
              controller: controller,
              backgroundColor: getBackGroundColor(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
