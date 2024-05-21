import 'package:basicfirebase/auth/page/sign_in.dart';
import 'package:basicfirebase/auth/page/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'common/appbar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignIn()//MyHomePage(title: 'Firebase Analytics Event', analytics: analytics),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.analytics});

  final String title;
  final FirebaseAnalytics analytics;

  @override
  State<MyHomePage> createState() => _MyHomePageState(analytics);
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState(this.analytics);

  final FirebaseAnalytics analytics;

  String _message = '';
  String _key = '';
  String _value ='';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void setDBMessage(String key, String value) {
    setState(() {
      _key = key.substring(1, key.length-1);
      _value = value.substring(1, value.length-1);
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'testevent_240502',
      parameters: <String, dynamic>{
        'string': 'hello',
        'int': 100,
      },
    );
    setMessage('send analytics~~~~!');
  }

  Future<void> createData() async {
    FirebaseDatabase realtime = FirebaseDatabase.instance;
    await realtime.ref().child("test").set({
      "testId": '123',
    });
  }

  Future<void> readData() async {
    FirebaseDatabase realtime = FirebaseDatabase.instance;
    DataSnapshot snapshot = await realtime.ref().child("test").get();
    Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
    print(value.keys);
    print(value.values);
    setDBMessage(value.keys.toString(), value.values.toString());
  }

  Future<void> updateData() async {
    FirebaseDatabase realtime = FirebaseDatabase.instance;
    await realtime.ref().child("test").update({"testId": '1234'});
  }

  Future<void> deleteData() async {
    FirebaseDatabase realtime = FirebaseDatabase.instance;
    await realtime.ref().child("test").remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _sendAnalyticsEvent,
              child: const Text('event test'),
            ),
            Text(
              _message,
              style: const TextStyle(color: Colors.blueAccent),
            ),
            ElevatedButton(
              onPressed: createData,
              child: const Text('createData'),
            ),
            ElevatedButton(
              onPressed: readData,
              child: const Text('readData'),
            ),
            Text(
              "KEY : $_key, VALUE : $_value",
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: updateData,
              child: const Text('updateData'),
            ),
            ElevatedButton(
              onPressed: deleteData,
              child: const Text('deleteData'),
            ),
          ],
        ),
      ),
    );
  }
}

