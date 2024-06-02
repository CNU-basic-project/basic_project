import 'package:basicfirebase/captain/screen/ship_register.dart';
import 'package:basicfirebase/captain/widget/ship_list_tile.dart';
import 'package:basicfirebase/common/constant.dart';
import 'package:basicfirebase/common/drawer.dart';
import 'package:basicfirebase/common/no_animation_route_button.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../domain/ship.dart';
import '../../provider/notifier_provider.dart';

class CaptainMain extends StatefulWidget {
  const CaptainMain({super.key});

  @override
  State<CaptainMain> createState() => _CaptainMainState();
}

class _CaptainMainState extends State<CaptainMain> {

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
                  leading: const Text("배 정보", style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            NoAnimationRouteBuilder(builder: (builder) =>
                                ShipRegister(ship: null,))
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
                      .height - 150,
                  child: FutureBuilder(
                    future: serviceProvider.shipService.get(
                        tokenProvider.token!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false || snapshot.hasError) {
                        return const CircularProgressIndicator();
                      }

                      List<Ship> ships = snapshot.data!;

                      return ListView.separated(
                        itemCount: ships.length,
                        itemBuilder: (BuildContext ctx, int idx) {
                          return ShipListTile(
                            ship: ships[idx],
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
