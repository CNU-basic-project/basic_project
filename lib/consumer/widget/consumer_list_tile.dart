import 'package:flutter/material.dart';

class ConsumerListTile extends StatelessWidget {
  const ConsumerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/ship.jpg'),
      title: const Text("Title"),
      subtitle: const Text("subtitle"),
      trailing: const Text("trailing"),
    );
  }
}
