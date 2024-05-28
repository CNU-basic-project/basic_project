import 'package:basicfirebase/common/search_field.dart';
import 'package:basicfirebase/consumer/domain/ship_repository.dart';
import 'package:basicfirebase/consumer/widget/main_info_list_view.dart';
import 'package:basicfirebase/consumer/widget/main_list_view.dart';
import 'package:basicfirebase/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/screen/sign_in.dart';
import '../../common/appbar.dart';
import '../../common/no_animation_route_button.dart';
import '../../main.dart';

class ConsumerMain extends StatefulWidget {
  const ConsumerMain({super.key});

  @override
  State<ConsumerMain> createState() => _ConsumerMainState();
}

class _ConsumerMainState extends State<ConsumerMain> {

  late final ShipRepository _shipRepository;
  late final User? _user;

  void getUser(BuildContext context) {
    _user = context.read<FirebaseRepository>().getUser();
  }

  Future<List<String>> getReservations(BuildContext context) {
    FirebaseFirestore firestore = context.read<FirebaseRepository>().firebaseFirestore;
    _shipRepository = ShipRepository(firebaseFirestore: firestore);
    return _shipRepository.getReservationsByUser(_user);
  }

  String searchQuery = '';
  DateTime? selectedDate;

  void _onChanged(String value) {
    searchQuery = value;
  }

  void _onSubmitted(String value) {
    setState(() {
      searchQuery = value;
      _onPressed();
    });
  }

  void _onPressed() {
    setState(() {
      searchQuery;
    });
  }

  @override
  Widget build(BuildContext context) {

    getUser(context);
    getReservations(context);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            ConsumerInfoListView(),
            const SizedBox(height: 10,),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 20,),
                  SearchField(
                    onPressed: _onPressed,
                    onChanged: _onChanged,
                    onSubmitted: _onSubmitted,
                  ),
                  const SizedBox(width: 10,),
                  IconButton(
                      onPressed: () {
                        showDatePicker(context: context, initialDate: selectedDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2050))
                          .then((selected) {
                            setState(() {
                              selectedDate = selected;
                            });
                          });
                      },
                      icon: const Icon(Icons.date_range, color: Colors.deepPurple, size: 30,)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            ConsumerListView(searchQuery: searchQuery, dateQuery: selectedDate,),
          ],
        ),
      ),
    );
  }
}

// --web-renderer html