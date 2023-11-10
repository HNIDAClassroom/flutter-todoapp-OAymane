import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist_app/models/task.dart';

class FirestoreService {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) {
    return tasksCollection.add(
      {
        'taskTitle': task.title,
        'taskDesc': task.description,
        'taskCategory': task.category.toString(),
      },
    );
  }
}
