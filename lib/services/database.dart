import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icue_cards/views/dir_root.dart';
import 'package:icue_cards/models/student.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference users = Firestore.instance.collection('users');

// when a new user signs up, we want to create a document for that user in the
// cuecardsCollection.
  Future updateUserData(String name, MainDirectory mainDirectory) async {
    return await users.document(uid).setData({
      'mainDirectory': mainDirectory,
      'name': name,
    });
  }

  List<Student> _mainDirectoryFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Student(
          name: doc.data['name'], mainDirectory: doc.data['mainDirectory']);
    }).toList();
  }

  // get cuecardcollection stream
  Stream<List<Student>> get userStream {
    return users.snapshots().map(_mainDirectoryFromSnapshot);
  }
}
