import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledproject/providers/task_provider.dart';

import '../../data/models/task_models.dart';

class Edittask extends StatefulWidget {
  final Task task;
  const Edittask({super.key, required this.task});

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveUpdatedTask() {

    final updatedTask = widget.task.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);
    //back
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title.isEmpty ? "Edit Task" : "Edit ${widget.task.title.toString()}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController, decoration: const InputDecoration(labelText: 'title'),
            ),
            TextField(
              controller: _descriptionController, decoration: const InputDecoration(labelText: "description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveUpdatedTask, child: const Text("Save Changes")),
          ],
        ),
      ),
    );
  }
}
