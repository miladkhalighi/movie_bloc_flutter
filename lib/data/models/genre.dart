import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Genre {
  final int id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], name: json['name']);

  @override
  String toString() => 'Genre(id: $id, name: $name)';

  @override
  bool operator ==(covariant Genre other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
