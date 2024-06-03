import 'dart:io';

import 'package:basicfirebase/captain/widget/input_data.dart';
import 'package:basicfirebase/common/API.dart';
import 'package:basicfirebase/common/no_animation_route_button.dart';
import 'package:basicfirebase/provider/notifier_provider.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../domain/ship.dart';
import 'departure_list.dart';

class ShipRegister extends StatefulWidget {

  final Ship? ship;

  ShipRegister({super.key, required this.ship});

  @override
  State<ShipRegister> createState() => _ShipRegisterState();
}

class _ShipRegisterState extends State<ShipRegister> {

  XFile? _image;
  final ImagePicker picker = ImagePicker();

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

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  String speed = "", seats = ""; // int
  String name = "", imagePath = "", type = ""; // String
  String weight = "", length = "", width = "", height = ""; // double
  DateTime launchDate = DateTime.now(); // DateTime

  bool validate() {
    try {
      int.parse(speed); int.parse(seats);
      double.parse(weight); double.parse(length); double.parse(width); double.parse(height);
      //DateFormat("yyyy-MM-dd").parse(launchDate); // launchDate가 String 일 때
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

    if (widget.ship != null) {
      speed = widget.ship!.speed.toString(); seats = widget.ship!.seats.toString(); // int
      name = widget.ship!.name; imagePath = widget.ship!.imagePath; type = widget.ship!.type; // String
      weight = widget.ship!.weight.toString(); length = widget.ship!.length.toString(); width = widget.ship!.width.toString(); height = widget.ship!.height.toString(); // double
      launchDate = widget.ship!.launchDate;
      //launchDate = DateFormat("yyyy-MM-dd").format(ship!.launchDate); //
    }

    TextEditingController launchDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(launchDate));

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
              id : widget.ship == null ? 0 : widget.ship!.id,
              speed : int.parse(speed),
              seats : int.parse(seats),
              name : name,
              imagePath: widget.ship == null ? BASIC_IMAGE_PATH : widget.ship!.imagePath,
              type : type,
              weight: double.parse(weight),
              length: double.parse(length),
              width: double.parse(width),
              height: double.parse(height),
              launchDate: launchDate,
              checkDate: widget.ship == null ? launchDate : widget.ship!.checkDate,
              //launchDate: DateFormat("yyyy-MM-dd").parse(launchDate),
              //checkDate: DateFormat("yyyy-MM-dd").parse(launchDate),
              owner: tokenProvider.member!
          );

          if (widget.ship == null) {
            String location = await serviceProvider.shipService.add(tokenProvider.token!, newShip);
            location = location.replaceAll("/ship/", "");
            if (_image != null) {
              await serviceProvider.shipService.putFile(_image!, location);
              newShip.imagePath = "$IMAGE_ENDPOINT/ship$location${p.extension(_image!.path)}";
            }
          } else {
            if (_image != null) {
              await serviceProvider.shipService.putFile(_image!, widget.ship!.id.toString());
              newShip.imagePath = "$IMAGE_ENDPOINT/ship${widget.ship!.id}${p.extension(_image!.path)}";
            }
          }
          await serviceProvider.shipService.update(tokenProvider.token!, newShip);
          notifierProvider.render();
          if (context.mounted) Navigator.pop(context);

        },
        child: Text(widget.ship == null ? "등록" : "수정", style: const TextStyle(color: Colors.white),),
      );
      if (widget.ship == null) {
        return elevatedButton;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          elevatedButton,
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR), onPressed: () {
            Navigator.push(
              context,
              NoAnimationRouteBuilder(builder: (builder) => DepartureList(ship: widget.ship!))
            );
          }, child: const Text("출항", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR), onPressed: () {

            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content: Text("정말로 [${widget.ship!.name}] 삭제하겠습니까?"),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await serviceProvider.shipService.delete(tokenProvider.token!, widget.ship!);
                        notifierProvider.render();
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (context.mounted) Navigator.pop(context);
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
            // InputData(title: "진수일", text: launchDate, onChanged: (value) {
            //   launchDate = value;
            // }),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "진수일",
                          style: const TextStyle(fontSize: 16),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: SearchBar(
                      controller: launchDateController,
                      backgroundColor: getBackGroundColor(),
                      trailing: [
                        IconButton(
                            onPressed: () {
                              showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime(2050)).then((selected) {
                                if (selected == null) return;
                                launchDate = selected;
                                launchDateController.text = DateFormat("yyyy-MM-dd").format(launchDate);
                              });
                            },
                            icon: const Icon(Icons.date_range, color: Colors.deepPurple, size: 30,)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), // 진수일

            const SizedBox(height: 10,),
            SizedBox(
              height: 120,
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Center(
                        child: Center(
                          child: Text(
                            "사진",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (builder) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: const Text("사진을 가져올 방법을 선택하세요."),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    getImage(ImageSource.camera);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constant.COLOR
                                  ),
                                  child: const Text("카메라", style: TextStyle(color: Colors.white),),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    getImage(ImageSource.gallery);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constant.COLOR
                                  ),
                                  child: const Text("갤러리", style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            );
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1),
                            borderRadius: BorderRadius.circular(30),
                            image: widget.ship == null || _image != null ? null :  DecorationImage(
                                fit: BoxFit.fill,
                                image: serviceProvider.getImage(widget.ship!.imagePath)
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0xD9, 0xD9, 0xD9, 1),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: _image == null ? (widget.ship == null ? const Center(child: Icon(Icons.add_a_photo_outlined, color: Colors.black))
                                : null)
                              : Image.file(File(_image!.path), fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

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
