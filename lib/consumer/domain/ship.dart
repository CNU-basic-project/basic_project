class Ship {

  final String imagePath, arrivalTime, arrivals, departureTime, departures, name, date;

  const Ship({
    required this.date,
    required this.arrivalTime,
    required this.arrivals,
    required this.departureTime,
    required this.imagePath,
    required this.name,
    required this.departures,
  });

  factory Ship.fromJson(Map<String, dynamic> json) {
    return Ship(
      date: json['date'],
      arrivals: json['arrivals'],
      arrivalTime: json['arrivalTime'],
      departures: json['departures'],
      departureTime: json['departureTime'],
      imagePath: json['imagePath'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "arrivals": arrivals,
      "arrivalTime": arrivalTime,
      "departures": departures,
      "departureTime": departureTime,
      "imagePath": imagePath,
      "name": name,
    };
  }
}