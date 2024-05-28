import 'departure.dart';
import 'member.dart';

class Reservation {

  final int id;
  final Member member;
  final Departure departure;

  Reservation({
    required this.id,
    required this.member,
    required this.departure,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id : json['id'],
      member: Member.fromJson(json['memberResponse']),
      departure: Departure.fromJson(json['departureResponse'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departureId' : departure.id,
    };
  }

}