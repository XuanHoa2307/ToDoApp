import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  // CREATE
  void addNewTask(TodoModel model){
    
    todoCollection.add(model.toMap());
  }

  // READ -> service_provider.dart

  // UPDATE
  void updateTask(String? docID, bool? valueUpdate){

    todoCollection.doc(docID).update({
      'isDone': valueUpdate
  });
  }

  // DELETE

  void deleteTask(String? docID){
    todoCollection.doc(docID).delete();
  }





}