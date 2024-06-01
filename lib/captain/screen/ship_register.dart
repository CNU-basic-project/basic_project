import 'package:basicfirebase/captain/screen/departure_register.dart';
import 'package:basicfirebase/captain/widget/input_data.dart';
import 'package:basicfirebase/common/API.dart';
import 'package:basicfirebase/common/no_animation_route_button.dart';
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

  final Ship? ship;

  ShipRegister({super.key, required this.ship});

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

    if (ship != null) {
      speed = ship!.speed.toString(); seats = ship!.seats.toString(); // int
      name = ship!.name; imagePath = ship!.imagePath; type = ship!.type; // String
      weight = ship!.weight.toString(); length = ship!.length.toString(); width = ship!.width.toString(); height = ship!.height.toString(); // double
      launchDate = DateFormat("yyyy-MM-dd").format(ship!.launchDate); //
    }

    Widget setButtons() {
      ElevatedButton elevatedButton = ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR),
        onPressed: () async {

          if (!validate()) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("입력이 올바르지 않습니다"),
              backgroundColor: Colors.blue,
            ));
            return;
          }

          Ship newShip = Ship(
              id : ship == null ? 0 : ship!.id,
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
          if (ship == null) {
            serviceProvider.shipService.add(tokenProvider.token!, newShip);
          } else {
            serviceProvider.shipService.update(tokenProvider.token!, newShip);
          }
          notifierProvider.render();
          Navigator.pop(context);

        },
        child: Text(ship == null ? "등록" : "수정", style: const TextStyle(color: Colors.white),),
      );
      if (ship == null) {
        return elevatedButton;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          elevatedButton,
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR), onPressed: () {
            Navigator.push(
              context,
              NoAnimationRouteBuilder(builder: (builder) => DepartureRegister(ship: ship!))
            );
          }, child: const Text("출항 등록", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR), onPressed: () {

            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content: Text("정말로 [${ship!.name}] 삭제하겠습니까?"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        serviceProvider.shipService.delete(tokenProvider.token!, ship!);
                        notifierProvider.render();
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constant.COLOR
                      ),
                      child: const Text("삭제", style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constant.COLOR
                      ),
                      child: const Text("취소", style: TextStyle(color: Colors.white),),
                    )
                  ],
                );
              },
            );

          }, child: const Text("삭제", style: TextStyle(color: Colors.white)),
          )
        ],
      );
    }

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
            InputData(title: "이름", text: name, onChanged: (value) {
              name = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "선박 종류", text: type, onChanged: (value) {
              type = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "전장", text: length, onChanged: (value) {
              length = value;
            }), // 전장,전폭,전고 // length width height

            const SizedBox(height: 10,),
            InputData(title: "전폭", text: width, onChanged: (value) {
              width = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "전고", text: height, onChanged: (value) {
              height = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "여객 정원", text: seats, onChanged: (value) {
              seats = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "출력", text: speed, onChanged: (value) {
              speed = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "톤 수", text: weight, onChanged: (value) {
              weight = value;
            }),

            const SizedBox(height: 10,),
            InputData(title: "진수일", text: launchDate, onChanged: (value) {
              launchDate = value;
            }),

            const SizedBox(height: 30,),
            Center(
              child: setButtons(),
            ),
          ],
        ),
      ),
    );
  }
}