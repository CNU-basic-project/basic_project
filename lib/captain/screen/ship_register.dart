import 'package:flutter/material.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';

class ShipRegister extends StatefulWidget {
  const ShipRegister({super.key});

  @override
  State<ShipRegister> createState() => _ShipRegisterState();
}

class _ShipRegisterState extends State<ShipRegister> {
  WidgetStateProperty<Color?> getBackGroundColor() {
    return WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1);
          }
      //   if (states.contains(WidgetState.pressed)) {
      //     return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 0.35); // 눌림 상태에서 파란색
      //   } else if (states.contains(WidgetState.disabled)) {
      //     return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 0.35); // 비활성 상태에서 회색
      //   }
      //   return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 0.35); // 기본 상태에서 초록색
      // },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize), child: MyAppBar()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "기본 정보",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "이름",
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: SearchBar(
                      backgroundColor: getBackGroundColor(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ), // 이름

            const SizedBox(height: 10,),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "운행 경로",
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SearchBar(
                            backgroundColor: getBackGroundColor(),
                            onChanged: (value) {

                            },
                          )
                        ),
                        Expanded(
                          flex: 1,
                          child: const Icon(Icons.arrow_forward_rounded, color: Constant.COLOR,)
                        ),
                        Expanded(
                            flex: 2,
                            child: SearchBar(
                              backgroundColor: getBackGroundColor(),
                              onChanged: (value) {

                              },
                            )
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ), // 운행 경로

            const SizedBox(height: 10,),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "운행시간",
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: SearchBar(
                                backgroundColor: getBackGroundColor(),
                                onChanged: (value) {

                                },
                              )
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ), // 운행 시간

            const SizedBox(height: 10,),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "좌석 수",
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: SearchBar(
                                backgroundColor: getBackGroundColor(),
                                onChanged: (value) {

                                },
                              )
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ), // 좌석 수

            const SizedBox(height: 10,),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Center(
                        child: Center(
                          child: Text(
                            "가격 (1매)",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: SearchBar(
                                backgroundColor: getBackGroundColor(),
                                onChanged: (value) {

                                },
                              )
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ), // 가격 1매

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

                        },
                        child: Container(
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  return;
                                },
                                icon: const Icon(Icons.add_a_photo_outlined, color: Constant.COLOR,),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0xD9, 0xD9, 0xD9, 1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                        ),
                      )
                  ),
                ],
              ),
            ), // 사진

          ],
        ),
      ),
    );
  }
}
