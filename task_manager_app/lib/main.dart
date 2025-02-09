import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/viewmodels/task_view_model.dart';
import 'package:task_manager_app/ui/views/add_task_screen.dart';
import 'package:task_manager_app/ui/views/home_screen.dart';
import 'package:task_manager_app/ui/views/task_detail_screen.dart';

import 'data/repositories/task_repository_impl.dart';
import 'data/services/task_service.dart';

void main() {

  // Set up dependency injection.
  final taskService = TaskService();
  final taskRepository = TaskRepositoryImpl(taskService: taskService);
  final taskViewModel = TaskViewModel(repository: taskRepository);

  runApp(MultiProvider(providers: [ChangeNotifierProvider<TaskViewModel>(
    create: (_) => taskViewModel,
  ),],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        TaskDetailScreen.routeName: (context) => const TaskDetailScreen(),
        AddTaskScreen.routeName: (context) => const AddTaskScreen(),
      },
    );
  }
}
