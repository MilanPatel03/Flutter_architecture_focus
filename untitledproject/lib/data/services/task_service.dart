
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_models.dart';

class TaskService {

  CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');

  Future<List<Task>> getTasks() async {

    final snapshot = await taskCollection.get();

    return snapshot.docs.map((doc) {

      final data = doc.data() as Map<String, dynamic>;

      return Task(id: doc.id, title: data['title'] ?? '', description: data['description'] ?? '', completed: data['completed'] ?? false);

    }).toList();
  }

  Future<Task?> getTask(String id) async {

    final single = await taskCollection.doc(id).get();
    if(single.exists) {
      final data = single.data() as Map<String, dynamic>;

      return Task(id: single.id, title: data['title'] ?? '', description: data['description'] ?? '');
    } return null;
  }

  Future<void> addTask(Task task) async {
    await taskCollection.add({'title': task.title, 'description': task.description, 'completed': task.completed});
  }

  Future<void> updateTask(Task task) async {

    await taskCollection.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'completed': task.completed,
    });
  }
  Future<void> deleteTask(String id) async {
    await taskCollection.doc(id).delete();
  }
}