import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../domain/departure.dart';
import '../../domain/ship.dart';

class DepartureRegister extends StatefulWidget {

  final Ship ship;

  const DepartureRegister({super.key, required this.ship});

  @override
  State<DepartureRegister> createState() => _DepartureRegisterState();
}

class _DepartureRegisterState extends State<DepartureRegister> {

  MaterialStateProperty<Color?> getBackGroundColor() {
    return MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1);
        }
    );
  }

  String departure = '';
  String arrival = '';
  DateTime date = DateTime.now();
  DateTime departureTime = DateTime.now();
  DateTime arrivalTime = DateTime.now();
  String price = '10000';

  void _departureChange(String departure) {
    this.departure = departure;
  }

  void _arrivalChange(String arrival) {
    this.arrival = arrival;
  }

  void _priceChange(String price) {
    this.price = price;
  }

  bool validate() {
    try {
      int.parse(price);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController departureTimeController = TextEditingController(text: DateFormat("HH:mm").format(departureTime));
    final TextEditingController arrivalTimeController = TextEditingController(text: DateFormat("HH:mm").format(arrivalTime));
    final TextEditingController dateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(date));

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
                            onChanged: _arrivalChange,
                          )
                        ),
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.arrow_forward_rounded, color: Colors.black,)
                        ),
                        Expanded(
                            flex: 2,
                            child: SearchBar(
                              backgroundColor: getBackGroundColor(),
                              onChanged: _departureChange,

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
                        child: Center(
                          child: Text(
                            "운행 날짜",
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
                                controller: dateController,
                                backgroundColor: getBackGroundColor(),
                                trailing: [
                                  IconButton(
                                      onPressed: () {
                                        showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2050)).then((selected) {
                                          setState(() {
                                            if (selected == null) return;
                                            date = selected;
                                            dateController.text = DateFormat("yyyy-MM-dd").format(date);
                                          });
                                        });
                                      },
                                      icon: const Icon(Icons.access_time_rounded, color: Colors.deepPurple, size: 30,)
                                  ),
                                ],
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
            ), // 날짜

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
                                controller: departureTimeController,
                                backgroundColor: getBackGroundColor(),
                                trailing: [
                                  IconButton(
                                      onPressed: () {
                                        showTimePicker(context: context, initialTime: TimeOfDay(hour: departureTime.hour, minute: departureTime.minute)).then((selected) {
                                          if (selected == null) return;
                                          setState(() {
                                            departureTime = DateTime(0, 0, 0, selected.hour, selected.minute);
                                            departureTimeController.text = DateFormat("HH:mm").format(departureTime);
                                          });
                                        });
                                      },
                                      icon: const Icon(Icons.access_time_rounded, color: Colors.deepPurple, size: 30,)
                                  ),
                                ],
                              )
                          ),
                          const Expanded(
                              flex: 1,
                              child: Icon(Icons.arrow_forward_rounded, color: Colors.black,)
                          ),
                          Expanded(
                              flex: 2,
                              child: SearchBar(
                                  controller: arrivalTimeController,
                                backgroundColor: getBackGroundColor(),
                                trailing: [
                                  IconButton(
                                      onPressed: () {
                                        showTimePicker(context: context, initialTime: TimeOfDay(hour: arrivalTime.hour, minute: arrivalTime.minute)).then((selected) {
                                          setState(() {
                                            if (selected == null) return;
                                            arrivalTime = DateTime(0, 0, 0, selected.hour, selected.minute, 0);
                                            arrivalTimeController.text = DateFormat("HH:mm").format(arrivalTime);
                                          });
                                        });
                                      },
                                      icon: const Icon(Icons.access_time_rounded, color: Colors.deepPurple, size: 30,)
                                  ),
                                ],
                              )
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
                                controller: TextEditingController(text: price),
                                backgroundColor: getBackGroundColor(),
                                onChanged: _priceChange,
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
                                  // TODO button 갤러리 or 카메라
                                  return;
                                },
                                icon: const Icon(Icons.add_a_photo_outlined, color: Colors.black),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0xD9, 0xD9, 0xD9, 1),
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

            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR),
              onPressed: () async {

                if (!validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("입력이 올바르지 않습니다"),
                    backgroundColor: Colors.blue,
                  ));
                  return;
                }

                Departure(
                  id: 0,
                  arrivals: arrival,
                  arrivalTime: arrivalTime,
                  departures: departure,
                  departureTime: departureTime,
                  date: date,
                  seat: 0,
                  price: int.parse(price),
                  ship: widget.ship,
                );

                Navigator.pop(context);

              },
              child: const Text("등록", style: TextStyle(color: Colors.white),),
            ), // TODO add, update?, delete?, show departure list and add or update || delete
          ],
        ),
      ),
    );
  }
}
