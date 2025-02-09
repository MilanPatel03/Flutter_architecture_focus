

import '../models/task_model.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchTasks();
  Future<void> addTask(Task task);
  Future<Task?> getTaskById(String id);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
}