// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Crew {
  int? id;
  String? name;
  String? department;
  String? job;
  String? profilePath;

  Crew({
    required this.id,
    required this.name,
    required this.department,
    required this.job,
    required this.profilePath,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      id: json['id'],
      name: json['name'],
      department: json['department'],
      job: json['job'],
      profilePath: json['profile_path'],
    );
  }

  Crew copyWith({
    int? id,
    String? name,
    String? department,
    String? job,
    String? profilePath,
  }) {
    return Crew(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
      job: job ?? this.job,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'department': department,
      'job': job,
      'profilePath': profilePath,
    };
  }

  factory Crew.fromMap(Map<String, dynamic> map) {
    return Crew(
      id: map['id'] as int,
      name: map['name'] as String,
      department: map['department'] as String,
      job: map['job'] as String,
      profilePath: map['profilePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Crew(id: $id, name: $name, department: $department, job: $job, profilePath: $profilePath)';
  }

  @override
  bool operator ==(covariant Crew other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.department == department &&
        other.job == job &&
        other.profilePath == profilePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        department.hashCode ^
        job.hashCode ^
        profilePath.hashCode;
  }

  String get imageUrl => 'https://image.tmdb.org/t/p/w500/$profilePath';

  factory Crew.initial() => Crew(
      id: -1,
      name: 'name',
      department: 'department',
      job: 'job',
      profilePath: 'profilePath');
}
