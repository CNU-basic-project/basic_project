import 'package:flutter/material.dart';

class ConsumerShipInfoTile extends StatelessWidget {
  const ConsumerShipInfoTile({
    super.key,
    required this.title,
    required this.trailing,
  });

  final String title, trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        trailing,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
