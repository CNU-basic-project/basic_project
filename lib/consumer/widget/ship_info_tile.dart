import 'package:flutter/material.dart';

class ConsumerShipInfoTile extends StatelessWidget {
  const ConsumerShipInfoTile({
    super.key,
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  final String title, trailing;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          ListTile(
            title: GestureDetector(
              onTap: onTap,
              child: Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
            ),
            trailing: Text(
              trailing,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 16,),
              GestureDetector(
                onTap: onTap,
                child: const Text("더보기", style: TextStyle(color: Colors.grey, fontSize: 10),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
