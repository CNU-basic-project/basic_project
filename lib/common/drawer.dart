import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {

  late TokenProvider tokenProvider;

  @override
  Widget build(BuildContext context) {

    tokenProvider = context.read<TokenProvider>();

    return Drawer(
      width: 320,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            accountName: Text(
              tokenProvider.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            accountEmail: null,
          ),
          const SizedBox(height: 20,),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('내 정보'),
            onTap: () {

            },
          ),
          const SizedBox(height: 20,),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('예약'),
            onTap: () {

            },
          ),
          const SizedBox(height: 20,),
          if (tokenProvider.permission! > 0) ListTile(
            leading: const Icon(Icons.directions_boat),
            title: const Text('배 정보'),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}