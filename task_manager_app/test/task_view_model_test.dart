// test/task_view_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/repositories/task_repository.dart';
import 'package:task_manager_app/ui/viewmodels/task_view_model.dart';

// A fake repository for testing purposes.
class FakeTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }

  @override
  Future<List<Task>> fetchTasks() async {
    return _tasks;
  }

  @override
  Future<Task?> getTaskById(String id) async {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }
}

void main() {
  group('TaskViewModel Tests', () {
    late TaskViewModel viewModel;
    late FakeTaskRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeTaskRepository();
      viewModel = TaskViewModel(repository: fakeRepository);
    });

    test('Adding a task increases the task list', () async {
      expect(viewModel.tasks.length, 0);
      await viewModel.addTask('Test Task', 'Test Description');
      expect(viewModel.tasks.length, 1);
      expect(viewModel.tasks.first.title, 'Test Task');
    });

    test('Deleting a task removes it from the task list', () async {
      await viewModel.addTask('Task to delete', 'Description');
      final taskId = viewModel.tasks.first.id;
      await viewModel.deleteTask(taskId);
      expect(viewModel.tasks.length, 0);
    });
  });
}
