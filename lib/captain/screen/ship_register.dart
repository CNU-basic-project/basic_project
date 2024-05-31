import 'package:basicfirebase/captain/widget/input_data.dart';
import 'package:basicfirebase/common/API.dart';
import 'package:basicfirebase/provider/notifier_provider.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../domain/member.dart';
import '../../domain/ship.dart';

class ShipRegister extends StatelessWidget {
  ShipRegister({super.key});

  late ServiceProvider serviceProvider;
  late TokenProvider tokenProvider;
  late NotifierProvider notifierProvider;

  MaterialStateProperty<Color?> getBackGroundColor() {
    return MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1);
        }
    );
  }

  String speed = "", seats = ""; // int
  String name = "", imagePath = "", type = ""; // String
  String weight = "", length = "", width = "", height = ""; // double
  String launchDate = ""; // DateTime

  bool validate() {
    try {
      int.parse(speed); int.parse(seats);
      double.parse(weight); double.parse(length); double.parse(width); double.parse(height);
      DateFormat("yyyy-MM-dd").parse(launchDate);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    serviceProvider = context.read<ServiceProvider>();
    tokenProvider = context.read<TokenProvider>();
    notifierProvider = context.read<NotifierProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "선박 정보 등록",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20,),
            InputData(title: "이름", onChanged: (value) {
              name = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "선박 종류", onChanged: (value) {
              type = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "전장", onChanged: (value) {
              length = value;
            }), // 전장,전폭,전고 // length width height

            const SizedBox(height: 10,),
            InputData(title: "전폭", onChanged: (value) {
              width = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "전고", onChanged: (value) {
              height = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "여객 정원", onChanged: (value) {
              seats = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "출력", onChanged: (value) {
              speed = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "톤 수", onChanged: (value) {
              weight = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "진수일", onChanged: (value) {
              launchDate = value;
            }),

            const SizedBox(height: 30,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR),
                onPressed: () {
                  // TODO 누르면 정보 등록 shipService로
                  if (!validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("입력이 올바르지 않습니다"),
                      backgroundColor: Colors.blue,
                    ));
                    return;
                  }

                  Ship ship = Ship(
                    id : 0,
                    speed : int.parse(speed),
                    seats : int.parse(seats),
                    name : name,
                    imagePath: BASIC_IMAGE_PATH,
                    type : type,
                    weight: double.parse(weight),
                    length: double.parse(length),
                    width: double.parse(width),
                    height: double.parse(height),
                    launchDate: DateFormat("yyyy-MM-dd").parse(launchDate),
                    checkDate: DateFormat("yyyy-MM-dd").parse(launchDate),
                    owner: tokenProvider.member!

                  );
                  serviceProvider.shipService.add(tokenProvider.token!, ship);
                  notifierProvider.render();
                  Navigator.pop(context);

                },
                child: const Text("등록", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
