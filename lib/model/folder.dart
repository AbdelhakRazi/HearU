// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Folder {
  String name;
  int nbRecords;
  String creationDate;
  double totalLength;
  Folder({
    required this.name,
    required this.nbRecords,
    required this.creationDate,
    required this.totalLength,
  });

  Folder copyWith({
    String? name,
    int? nbRecords,
    String? creationDate,
    double? totalLength,
  }) {
    return Folder(
      name: name ?? this.name,
      nbRecords: nbRecords ?? this.nbRecords,
      creationDate: creationDate ?? this.creationDate,
      totalLength: totalLength ?? this.totalLength,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'nbRecords': nbRecords,
      'creationDate': creationDate,
      'totalLength': totalLength,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      name: map['name'] as String,
      nbRecords: map['nbRecords'] as int,
      creationDate: map['creationDate'] as String,
      totalLength: map['totalLength'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Folder.fromJson(String source) =>
      Folder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Folder(name: $name, nbRecords: $nbRecords, creationDate: $creationDate, totalLength: $totalLength)';
  }

  @override
  bool operator ==(covariant Folder other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.nbRecords == nbRecords &&
        other.creationDate == creationDate &&
        other.totalLength == totalLength;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        nbRecords.hashCode ^
        creationDate.hashCode ^
        totalLength.hashCode;
  }
}
