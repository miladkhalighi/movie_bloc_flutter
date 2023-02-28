// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cast {
  int? id;
  String? name;
  String? character;
  String? profilePath;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'],
    );
  }

  Cast copyWith({
    int? id,
    String? name,
    String? character,
    String? profilePath,
  }) {
    return Cast(
      id: id ?? this.id,
      name: name ?? this.name,
      character: character ?? this.character,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'character': character,
      'profilePath': profilePath,
    };
  }

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      id: map['id'] as int,
      name: map['name'] as String,
      character: map['character'] as String,
      profilePath: map['profilePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Cast(id: $id, name: $name, character: $character, profilePath: $profilePath)';
  }

  @override
  bool operator ==(covariant Cast other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.character == character &&
        other.profilePath == profilePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        character.hashCode ^
        profilePath.hashCode;
  }

  String get imageUrl => 'https://image.tmdb.org/t/p/w500/$profilePath';
  factory Cast.initial() => Cast(
      id: -1, name: 'name', character: 'character', profilePath: 'profilePath');
}
