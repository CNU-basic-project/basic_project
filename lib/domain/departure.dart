import 'package:basicfirebase/domain/ship.dart';

class Departure {

  final int id, price, seat;
  final DateTime date, departureTime, arrivalTime;
  final String departures, arrivals;
  final Ship ship;

  Departure({
    required this.id,
    required this.price,
    required this.seat,
    required this.date,
    required this.departures,
    required this.arrivalTime,
    required this.departureTime,
    required this.arrivals,
    required this.ship
  });

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      id : json['id'],
      price : json['speed'],
      seat : json['seats'],
      date : json['name'],
      departures : json['imagePath'],
      arrivalTime : json['type'],
      departureTime : json['weight'],
      arrivals : json['length'],
      ship : Ship.fromJson(json['shipResponse']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "price" : price,
      "date" : date,
      "departures" : departures,
      "arrivalTime" : arrivalTime,
      "departureTime" : departureTime,
      "arrivals" : arrivals,
      "shipId" : ship.id,
    };
  }
}