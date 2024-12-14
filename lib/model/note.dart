// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  final int? id;
  final String title;
  final String content;
  final String audioPath;
  final double audioLength;
  bool isFavorite;

  Note(
      {this.id,
      required this.title,
      required this.content,
      required this.audioPath,
      required this.audioLength,
      this.isFavorite = false});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      audioPath: json['audioPath'] as String,
      audioLength: json['audioLength'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'audioPath': audioPath,
      'audioLength': audioLength,
    };
  }

  Note copyWith({
    int? id,
    String? title,
    String? content,
    String? audioPath,
    double? audioLength,
    bool? isFavorite,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      audioPath: audioPath ?? this.audioPath,
      audioLength: audioLength ?? this.audioLength,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
