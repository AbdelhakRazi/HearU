// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  final String title;
  final String content;
  final String audioPath;
  final double audioLength;

  Note({
    required this.title,
    required this.content,
    required this.audioPath,
    required this.audioLength,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
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
}
