import 'package:basicfirebase/captain/widget/input_data.dart';
import 'package:flutter/material.dart';

import '../../common/appbar.dart';

class ShipRegister extends StatelessWidget {
  const ShipRegister({super.key});

  WidgetStateProperty<Color?> getBackGroundColor() {
    return WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            InputData(title: "이름", onChanged: (value) {

            }),

            const SizedBox(height: 20,),
            InputData(title: "선박 종류", onChanged: (value) {

            }),

            const SizedBox(height: 20,),
            InputData(title: "길이 전장", onChanged: (value) {

            }),

            const SizedBox(height: 20,),
            InputData(title: "여객 정원", onChanged: (value) {

            }),

            const SizedBox(height: 20,),
            InputData(title: "톤 수", onChanged: (value) {

            }),

            const SizedBox(height: 20,),
            InputData(title: "진수일", onChanged: (value) {

            }),
          ],
        ),
      ),
    );
  }
}
