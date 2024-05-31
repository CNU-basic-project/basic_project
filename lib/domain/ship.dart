import 'package:basicfirebase/domain/member.dart';
import 'package:intl/intl.dart';

class Ship {

  final int id;
  int speed, seats;
  String name, imagePath, type;
  double weight, length, width, height;
  DateTime launchDate;
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
    required this.owner,
  });

  factory Ship.fromJson(Map<String, dynamic> json) {

    json['launchDate'] = DateFormat("yyyy-MM-dd").parse(json['launchDate']);

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
      "launchDate" : launchDate,
      "owner" : owner.toJson(),
    };
  }
}