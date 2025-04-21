import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledproject/data/models/task_models.dart';
import 'package:untitledproject/providers/task_provider.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  void _submitTask() async {
    if(_formKey.currentState!.validate()) {

      _formKey.currentState!.save();

      final newTask = Task(id: '', title: _title, description: _description);

      await Provider.of<TaskProvider>(context, listen: false).addTask(newTask);

      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task Screen"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'title'),
              validator: (value) => value == null || value.isEmpty ? "Enter title" : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'description'),
              validator: (value) => value == null || value.isEmpty ? "Enter description" : null,
              onSaved: (value) => _description = value!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitTask,
              child: const Text('Save Task'),
            )
          ],
        )),
      ),
    );
  }
}
