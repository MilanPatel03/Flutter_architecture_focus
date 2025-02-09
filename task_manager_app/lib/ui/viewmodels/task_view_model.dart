import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;
  List<Task> _tasks = [];
  bool _isLoading = false;

  TaskViewModel({required this.repository});

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  // Load tasks from the repository.
  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    _tasks = await repository.fetchTasks();

    _isLoading = false;
    notifyListeners();
  }

  // Add a new task.
  Future<void> addTask(String title, String description) async {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    await repository.addTask(newTask);
    notifyListeners();
  }

  // Update an existing task.
  Future<void> updateTask(Task updatedTask) async {
    await repository.updateTask(updatedTask);
    int index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  // Delete a task.
  Future<void> deleteTask(String id) async {
    await repository.deleteTask(id);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
