// lib/ui/screens/task_detail_screen.dart
import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/taskDetail';

  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(task.description),
      ),
    );
  }
}
