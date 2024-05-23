import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: const Icon(Icons.search),
      trailing: [
        IconButton(
            onPressed: () {
              print('search');
            },
            icon: const Icon(Icons.send)
        ),
      ],
    );
  }
}
