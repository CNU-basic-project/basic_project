import 'package:basicfirebase/auth/screen/sign_in.dart';
import 'package:basicfirebase/provider/notifier_provider.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:basicfirebase/service/ai_service.dart';
import 'package:basicfirebase/service/auth_service.dart';
import 'package:basicfirebase/service/departure_service.dart';
import 'package:basicfirebase/service/reservation_service.dart';
import 'package:basicfirebase/service/ship_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NotifierProvider>(
        create: (context) => NotifierProvider(),
      ),
      Provider<TokenProvider>(
        create: (context) => TokenProvider(token: '', authService: AuthService()),
      ),
      Provider<ServiceProvider>(
        create: (context) => ServiceProvider(
          authService: AuthService(),
          departureService: DepartureService(),
          reservationService: ReservationService(),
          shipService: ShipService(),
          aiService: AIService(),
        ),
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Main()
      ),
    ),
  ));
}


class Main extends StatelessWidget {
  Main({super.key});

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
