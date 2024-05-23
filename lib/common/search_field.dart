import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {

  final Function() onPressed;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const SearchField({
    super.key,
    required this.onPressed,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: SearchBar(
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        leading: const Icon(Icons.search),
        trailing: [
          IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.send)
          ),
        ],
      ),
    );
  }
}
