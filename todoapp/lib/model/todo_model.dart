import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String titleTask;
  final String description;
  final String category;
  final String dateTask;
  final String timeTask;
  final bool isDone;

  TodoModel( {
    this.docID,
    required this.titleTask,
    required this.description,
    required this.category,
    required this.dateTask,
    required this.timeTask,
    required this.isDone,
    }); 

  Map<String, dynamic> toMap() {
  return <String, dynamic>{
     //'docID': docID,
    'titleTask': titleTask,
    'description': description,
    'category': category,
    'dateTask': dateTask,
    'timeTask': timeTask,
    'isDone': isDone,
  };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleTask: map['titleTask'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
      isDone: map['isDone'] as bool,
    );
  }


  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
  return TodoModel(
    docID: doc.id,
    titleTask: doc.data()?['titleTask'] ?? 'No Title',
    description: doc.data()?['description'] ?? 'No Description',
    category: doc.data()?['category'] ?? 'No Category',
    dateTask: doc.data()?['dateTask'] ?? 'No Date',
    timeTask: doc.data()?['timeTask'] ?? 'No Time',
    isDone: doc.data()?['isDone'] ?? false, // Xử lý an toàn
  );
}


}