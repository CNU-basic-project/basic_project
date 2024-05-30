import 'package:basicfirebase/captain/widget/ship_list_tile.dart';
import 'package:basicfirebase/common/constant.dart';
import 'package:basicfirebase/common/drawer.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../domain/ship.dart';

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
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      endDrawer: MyDrawer(),

      // TODO screen 구성
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("배 정보", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              IconButton(
                onPressed: () {
                  // TODO move to ship_info
                },
                icon: const Icon(Icons.add_circle_outline_rounded, color: Constant.COLOR),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          FutureBuilder(
            future: serviceProvider.shipService.get(tokenProvider.token!),
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

        ],
      ),

    );
  }
}
