// lib/data/models/task_model.dart
import 'package:meta/meta.dart';

@immutable //USE IMMUTABLE to ensures that once a task is created, its data is not accidentally changed.
class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Helper method to create a modified copy.
  Task copyWith({String? id, String? title, String? description, bool? completed}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
