class Member {
  final int id;
  final String name;

  Member({
    required this.id,
    required this.name,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "name" : name,
    };
  }
}