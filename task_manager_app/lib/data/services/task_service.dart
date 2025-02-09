// lib/data/services/task_service.dart
import 'dart:async';
import '../models/task_model.dart';

class TaskService {
  // Simulated data source
  final List<Task> _tasks = [];

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay
    return _tasks;
  }

  Future<void> addTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.add(task);
  }

  Future<Task?> getTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    await Future.delayed(const Duration(milliseconds: 300));
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  Future<void> deleteTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.removeWhere((task) => task.id == id);
  }
}
