import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/tasks.dart';
import 'package:todolist_app/tasks_list.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key, required this.onAddTask}) : super(key: key);

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final Category _defaultCategory = Category.personal;
  Category? _selectedCategory = Category.personal;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  List<DropdownMenuItem<Category>> _buildDropdownMenuItems() {
    return Category.values.map((category) {
      return DropdownMenuItem<Category>(
        value: category,
        child: Text(
          category.toString().split('.').last.toUpperCase(),
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTaskData() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final category = _selectedCategory!;
    final date = _selectedDate;

    if (title.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final newTask = Task(
      title: title,
      description: description,
      category: category,
      date: date,
    );

    widget.onAddTask(newTask);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Tasks()),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2024),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              labelText: 'Titre de la tâche',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 100,
            decoration: const InputDecoration(
              labelText: 'Description de la tâche',
            ),
          ),
          Row(
            children: [
              DropdownButton<Category>(
                value: _selectedCategory,
                items: _buildDropdownMenuItems(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _selectDate,
                child: const Text('Sélectionner une date'),
              ),
            ],
          ),
          Text('Date sélectionnée : ${_selectedDate.toString()}'),
          ElevatedButton(
            onPressed: _submitTaskData,
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}
