import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart' as task_model;
import 'package:todolist_app/new_task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();
  final List<task_model.Task> _registeredTasks = [
    task_model.Task(
      title: 'Apprendre Flutter',
      description: 'Suivre le cours pour apprendre de nouvelles compétences',
      date: DateTime.now(),
      category: task_model.Category.work,
    ),
    task_model.Task(
      title: 'Faire les courses',
      description: 'Acheter des provisions pour la semaine',
      date: DateTime.now().subtract(Duration(days: 1)),
      category: task_model.Category.shopping,
    ),
    task_model.Task(
      title: 'Rédiger un CR',
      description: '',
      date: DateTime.now().subtract(Duration(days: 2)),
      category: task_model.Category.personal,
    ),
  ];

  void _deleteTask(task_model.Task task) {
    setState(() {
      _registeredTasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The title'),
          Expanded(
              child: TasksList(
                  tasks: _registeredTasks, onDeleteTask: _deleteTask)),
        ],
      ),
    );
  }

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(task_model.Task task) {
    setState(() {
      _registeredTasks.add(task);
      firestoreService.addTask(task);
      Navigator.pop(context);
    });
  }
}
