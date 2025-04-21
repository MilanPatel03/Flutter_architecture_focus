import 'package:flutter/material.dart';

import '../models/task_models.dart';
import '../services/task_service.dart';

class TaskRepository {

  final TaskService _taskService;
  TaskRepository(this._taskService);

  Future<List<Task>> getTasks() => _taskService.getTasks();

  Future<void> addTask(Task task) => _taskService.addTask(task);

  Future<Task?> getTask(String id) => _taskService.getTask(id);

  Future<void> updateTask(Task task) => _taskService.updateTask(task);

  Future<void> deleteTask(String id) => _taskService.deleteTask(id);
}