import 'package:basicfirebase/consumer/widget/main_info_card.dart';
import 'package:flutter/material.dart';

class ConsumerInfoListView extends StatelessWidget {
  const ConsumerInfoListView({super.key});

  static const double HEIGHT = 200.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HEIGHT,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // TODO more detail
          ConsumerInfoCard(child: Image.asset("assets/info.png", width: 300,)),
          ConsumerInfoCard(child: Image.asset("assets/info.png", width: 300,)),
          ConsumerInfoCard(child: Image.asset("assets/info.png", width: 300,)),
          ConsumerInfoCard(child: Image.asset("assets/info.png", width: 300,)),
          ConsumerInfoCard(child: Image.asset("assets/info.png", width: 300,)),
          ConsumerInfoCard(child: Text("ㅎㅇ")),
          ConsumerInfoCard(child: Icon(Icons.abc)),
        ],
      ),
    );
  }
}
