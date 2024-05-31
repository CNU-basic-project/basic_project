class Member {
  final int id;
  final String name;
  final int permission;

  Member({
    required this.id,
    required this.name,
    required this.permission,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      permission: json['permission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "name" : name,
      "permission" : permission,
    };
  }
}