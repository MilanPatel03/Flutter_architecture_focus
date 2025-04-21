import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledproject/providers/task_provider.dart';
import 'package:untitledproject/ui/views/addTask.dart';
import 'package:untitledproject/ui/views/editTask.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  void _deleteTask(BuildContext context, String TaskId) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Delete Task"),
              content: const Text("Are you sure you want to delete this task?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("Cancel", style: TextStyle(color: Colors.grey),)),
                TextButton(
                  onPressed: () async {
                    Provider.of<TaskProvider>(context, listen: false).deleteTask(TaskId);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Delete", style: TextStyle(color: Colors.red),),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: taskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : taskProvider.tasks.isEmpty
              ? const Center(child: Text("No task available"))
              : ListView.builder(
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                Edittask(task: task),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit_rounded)),
                                  IconButton(
                                      onPressed: () {
                                        _deleteTask(context, task.id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                task.title,
                                style: TextStyle(
                                    decoration: task.completed
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
                              subtitle: Text(task.description),
                              trailing: Checkbox(
                                  value: task.completed,
                                  onChanged: (value) async {
                                    if (value == null) return;
                                    final updatedTask =
                                        task.copyWith(completed: value);
                                    await taskProvider.updateTask(updatedTask);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Addtask()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} /*  */
