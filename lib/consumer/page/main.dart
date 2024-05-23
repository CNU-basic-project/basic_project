import 'package:basicfirebase/common/search_field.dart';
import 'package:basicfirebase/consumer/widget/consumer_info_list_view.dart';
import 'package:basicfirebase/consumer/widget/consumer_list_view.dart';
import 'package:flutter/material.dart';

import '../../common/appbar.dart';
import '../../common/no_animation_route_button.dart';
import '../../main.dart';

class ConsumerMain extends StatefulWidget {
  const ConsumerMain({super.key});

  @override
  State<ConsumerMain> createState() => _ConsumerMainState();
}

class _ConsumerMainState extends State<ConsumerMain> {

  String searchQuery = '';

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
                        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2050))
                          .then((selectedDate) {

                          });
                      },
                      icon: const Icon(Icons.date_range, color: Colors.deepPurple, size: 30,)
                  ),
                ],
              ),
            ),
            // ElevatedButton(onPressed: () {
            //   Navigator.push(
            //     context,
            //     NoAnimationRouteBuilder(builder: (context) => MyHomePage(title: 'Firebase Analytics Event', analytics: MyApp.analytics))
            //   );
            // }
            //     , child: const Icon(Icons.smart_button)),
            const SizedBox(height: 10,),
            ConsumerListView(searchQuery: searchQuery,),
          ],
        ),
      ),
    );
  }
}
