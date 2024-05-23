import 'package:basicfirebase/consumer/widget/consumer_info_card.dart';
import 'package:flutter/material.dart';

class ConsumerInfoListView extends StatelessWidget {
  const ConsumerInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ConsumerInfoCard(child: Image.asset("assets/info.png")),
          ConsumerInfoCard(child: Image.asset("assets/info.png")),
          ConsumerInfoCard(child: Image.asset("assets/info.png")),
          ConsumerInfoCard(child: Image.asset("assets/info.png")),
          ConsumerInfoCard(child: Text("ㅎㅇ")),
          ConsumerInfoCard(child: Icon(Icons.abc)),
        ],
      ),
    );
  }
}
