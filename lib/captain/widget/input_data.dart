import 'package:flutter/material.dart';

class InputData extends StatelessWidget {
  const InputData({
    super.key,
    required this.title,
    required this.onChanged,
  });

  final String title;
  final Function(String) onChanged;

  WidgetStateProperty<Color?> getBackGroundColor() {
    return WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1);
        }
    );
  }


  @override
  Widget build(BuildContext context) {
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
              backgroundColor: getBackGroundColor(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
