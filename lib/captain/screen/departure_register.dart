import 'package:basicfirebase/provider/notifier_provider.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../domain/departure.dart';
import '../../domain/ship.dart';

class DepartureRegister extends StatefulWidget {

  final Ship ship;
  final Departure? departure;

  const DepartureRegister({super.key, required this.ship, required this.departure});

  @override
  State<DepartureRegister> createState() => _DepartureRegisterState();
}

class _DepartureRegisterState extends State<DepartureRegister> {

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

    serviceProvider = context.read<ServiceProvider>();
    tokenProvider = context.read<TokenProvider>();
    notifierProvider = context.read<NotifierProvider>();

    if (widget.departure != null) {
      departure = widget.departure!.departures;
      arrival = widget.departure!.arrivals;
      date = widget.departure!.date;
      departureTime = widget.departure!.departureTime;
      arrivalTime = widget.departure!.arrivalTime;
      price = widget.departure!.price.toString();
    }

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
            Text(
              "${widget.ship.name} 출항 정보",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30,),
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
                            controller: TextEditingController(text: departure),
                            backgroundColor: getBackGroundColor(),
                            onChanged: _departureChange,
                          )
                        ),
                        const Expanded(
                          flex: 1,
                          child: Icon(Icons.arrow_forward_rounded, color: Colors.black,)
                        ),
                        Expanded(
                            flex: 2,
                            child: SearchBar(
                              controller: TextEditingController(text: arrival),
                              backgroundColor: getBackGroundColor(),
                              onChanged: _arrivalChange,

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
                      child: SearchBar(
                        controller: dateController,
                        backgroundColor: getBackGroundColor(),
                        trailing: [
                          IconButton(
                              onPressed: () {
                                showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2050)).then((selected) {
                                  if (selected == null) return;
                                  date = selected;
                                  dateController.text = DateFormat("yyyy-MM-dd").format(date);
                                });
                              },
                              icon: const Icon(Icons.date_range, color: Colors.deepPurple, size: 30,)
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
                                          departureTime = DateTime(0, 0, 0, selected.hour, selected.minute);
                                          departureTimeController.text = DateFormat("HH:mm").format(departureTime);
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
                                          if (selected == null) return;
                                          arrivalTime = DateTime(0, 0, 0, selected.hour, selected.minute, 0);
                                          arrivalTimeController.text = DateFormat("HH:mm").format(arrivalTime);
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

            const SizedBox(height: 30,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Constant.COLOR),
                onPressed: () async {

                  if (widget.departure != null) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: const Text("정말로 삭제하겠습니까?"),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {

                                await serviceProvider.departureService.delete(tokenProvider.token!, widget.departure!);
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
                    return;
                  }

                  if (!validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("입력이 올바르지 않습니다"),
                      backgroundColor: Colors.blue,
                    ));
                    return;
                  }

                  Departure newDeparture = Departure(
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

                  await serviceProvider.departureService.add(tokenProvider.token!, newDeparture);
                  notifierProvider.render();

                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(widget.departure == null ? "등록" : "삭제", style: const TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
