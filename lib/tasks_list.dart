import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart' as task_model;

class TaskItem extends StatelessWidget {
  final task_model.Task task;
  final VoidCallback onDelete;

  const TaskItem({Key? key, required this.task, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          task.toggleCompleted();
        },
      ),
      title: Text(task.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.description,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            'Due: ${task.date.toString()}',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}

class TasksList extends StatelessWidget {
  final List<task_model.Task> tasks;
  final Function(task_model.Task) onDeleteTask;

  const TasksList({Key? key, required this.tasks, required this.onDeleteTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskItem(
          task: task,
          onDelete: () => onDeleteTask(task),
        );
      },
    );
  }
}
