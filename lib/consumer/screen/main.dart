import 'package:basicfirebase/common/search_field.dart';
import 'package:basicfirebase/consumer/widget/main_info_list_view.dart';
import 'package:basicfirebase/consumer/widget/main_list_view.dart';
import 'package:basicfirebase/provider/notifier_provider.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';

class ConsumerMain extends StatefulWidget {
  const ConsumerMain({super.key});

  @override
  State<ConsumerMain> createState() => _ConsumerMainState();
}

class _ConsumerMainState extends State<ConsumerMain> {

  late TokenProvider tokenProvider;
  late ServiceProvider serviceProvider;

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

    tokenProvider = context.read<TokenProvider>();
    serviceProvider = context.read<ServiceProvider>();
    
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
                        icon: Icon(Icons.date_range, color: selectedDate == null ? Colors.grey : Colors.deepPurple, size: 30,)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Consumer<NotifierProvider>(
                builder: (_, notifier, __) {
                  return ConsumerListView(searchQuery: searchQuery, dateQuery: selectedDate,);
                },
              )
            ],
          ),
        ),
      );
  }
}

// --web-renderer html