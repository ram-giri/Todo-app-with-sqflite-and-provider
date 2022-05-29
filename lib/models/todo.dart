import 'dart:convert';

class Todo {
  final int? id;
  final String title;
  final String discription;
  late final String isChecked;
  Todo({
    this.id,
    required this.title,
    required this.discription,
    required this.isChecked,
  });

  Todo copyWith({
    int? id,
    String? title,
    String? discription,
    String? isChecked,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      discription: discription ?? this.discription,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'discription': discription});
    result.addAll({'isChecked': isChecked});

    return result;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      discription: map['discription'] ?? '',
      isChecked: map['isChecked'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() =>
      'Todo(id: $id, title: $title, discription: $discription, isChecked: $isChecked)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.discription == discription &&
        other.isChecked == isChecked;
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ discription.hashCode ^ isChecked.hashCode;
}
