class Ship {

  final String imagePath, arrivalTime, arrivals, departureTime, departures, name, date, uid;
  final int seat, maxSeat, price;

  const Ship({
    required this.uid,
    required this.date,
    required this.arrivalTime,
    required this.arrivals,
    required this.departureTime,
    required this.imagePath,
    required this.name,
    required this.departures,
    required this.seat,
    required this.maxSeat,
    required this.price,
  });

  factory Ship.fromJson(Map<String, dynamic> json) {
    return Ship(
      uid: json['uid'],
      date: json['date'],
      arrivals: json['arrivals'],
      arrivalTime: json['arrivalTime'],
      departures: json['departures'],
      departureTime: json['departureTime'],
      imagePath: json['imagePath'],
      name: json['name'],
      seat: json['seat'],
      maxSeat: json['maxSeat'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "date": date,
      "arrivals": arrivals,
      "arrivalTime": arrivalTime,
      "departures": departures,
      "departureTime": departureTime,
      "imagePath": imagePath,
      "name": name,
      "seat": seat,
      "maxSeat": maxSeat,
      "price": price,
    };
  }
}