import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/views/task_detail_screen.dart';

import '../viewmodels/task_view_model.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late TaskViewModel taskViewModel;

  @override
  void initState() {
    super.initState();
    // Load tasks when the screen is initialized.
    taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    taskViewModel.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.tasks.isEmpty) {
            return const Center(child: Text('No tasks found.'));
          }
          return ListView.builder(
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = viewModel.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => viewModel.deleteTask(task.id),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TaskDetailScreen.routeName,
                    arguments: task,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddTaskScreen.routeName);
        },
      ),
    );
  }
}
