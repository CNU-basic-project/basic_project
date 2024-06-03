import 'package:basicfirebase/captain/screen/departure_register.dart';
import 'package:basicfirebase/captain/widget/departure_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../common/drawer.dart';
import '../../common/no_animation_route_button.dart';
import '../../domain/departure.dart';
import '../../domain/ship.dart';
import '../../provider/notifier_provider.dart';
import '../../provider/service_provider.dart';
import '../../provider/token_provider.dart';

class DepartureList extends StatefulWidget {
  const DepartureList({super.key, required this.ship});
  
  final Ship ship;

  @override
  State<DepartureList> createState() => _DepartureList();
}

class _DepartureList extends State<DepartureList> {

  late ServiceProvider serviceProvider;
  late TokenProvider tokenProvider;

  @override
  Widget build(BuildContext context) {

    serviceProvider = context.read<ServiceProvider>();
    tokenProvider = context.read<TokenProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      endDrawer: MyDrawer(),

      body: Consumer<NotifierProvider>(
          builder: (_, notifier, __) {
            return SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - preferredSize,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  ListTile(
                    leading: Text("${widget.ship.name} 출항 정보", style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              NoAnimationRouteBuilder(builder: (builder) =>
                                  DepartureRegister(ship: widget.ship, departure: null,))
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline_rounded,
                          color: Constant.COLOR,)
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - preferredSize - 100,
                    child: FutureBuilder(
                      future: serviceProvider.departureService.findAllByShip(
                          widget.ship),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false || snapshot.hasError) {
                          return const CircularProgressIndicator();
                        }

                        List<Departure> departures = snapshot.data!;

                        return ListView.separated(
                          itemCount: departures.length,
                          itemBuilder: (BuildContext ctx, int idx) {
                            return DepartureListTile(
                              departure: departures[idx],
                            );
                          },
                          separatorBuilder: (BuildContext ctx, int idx) {
                            return const Divider();
                          },
                        );
                      },
                    ),
                  ),

                ],
              ),
            );
          }
      ),

    );
  }
}