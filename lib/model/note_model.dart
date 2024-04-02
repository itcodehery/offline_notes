class Note {
  int id;
  final String title;
  final String content;
  final DateTime timestamp;

  Note({
    this.id = 0,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'Note {title: $title, content: $content, timestamp: $timestamp}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}
