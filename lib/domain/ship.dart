import 'package:basicfirebase/domain/member.dart';
import 'package:intl/intl.dart';

class Ship {

  final int id;
  int speed, seats;
  String name, imagePath, type;
  double weight, length, width, height;
  DateTime launchDate, checkDate;
  final Member owner;

  Ship({
    required this.id,
    required this.speed,
    required this.seats,
    required this.name,
    required this.imagePath,
    required this.type,
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.launchDate,
    required this.checkDate,
    required this.owner,
  });

  factory Ship.fromJson(Map<String, dynamic> json) {

    json['launchDate'] = DateFormat("yyyy-MM-dd").parse(json['launchDate']);
    json['checkDate'] = DateFormat("yyyy-MM-dd").parse(json['checkDate']);

    return Ship(
      id : json['id'],
      speed : json['speed'],
      seats : json['seats'],
      name : json['name'],
      imagePath : json['imagePath'],
      type : json['type'],
      weight : json['weight'],
      length : json['length'],
      width : json['width'],
      height : json['height'],
      launchDate: json['launchDate'],
      checkDate: json['checkDate'],
      owner : Member.fromJson(json['owner']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name" : name,
      "imagePath" : imagePath,
      "seats" : seats,
      "type" : type,
      "speed" : speed,
      "weight" : weight,
      "length" : length,
      "width" : width,
      "height" : height,
      "launchDate" : DateFormat("yyyy-MM-dd").format(launchDate),
      "checkDate" : DateFormat("yyyy-MM-dd").format(checkDate),
      "owner" : owner.toJson(),
    };
  }
}