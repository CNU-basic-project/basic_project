import 'package:basicfirebase/domain/ship.dart';
import 'package:intl/intl.dart';

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

    json['date'] = DateFormat("yyyy-MM-dd").parse(json['date']);
    json['arrivalTime'] = DateFormat("HH:mm:ss").parse(json['arrivalTime']);
    json['departureTime'] = DateFormat("HH:mm:ss").parse(json['departureTime']);

    return Departure(
      id : json['id'],
      price : json['price'],
      seat : json['seat'],
      date : json['date'],
      departures : json['departures'],
      arrivalTime : json['arrivalTime'],
      departureTime : json['departureTime'],
      arrivals : json['arrivals'],
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