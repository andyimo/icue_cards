/* What sorts of information do we need to store for the user in the cloud
   i.e. what stuff do we need to remember for the user when they sign back in?
   - language
   - theme 
   - name 
   - cue card decks
   - file system???
*/
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference cuecardCollection =
      Firestore.instance.collection('cuecards');

// when a new user signs up, we want to create a document for that user in the
// cuecardsCollection.
  Future updateUserData(String language, String name) async {
    return await cuecardCollection.document(uid).setData({
      'langage': language,
      'name': name,
    });
  }

  // get cuecardcollection stream
  Stream<QuerySnapshot> get icuecards {
    return cuecardCollection.snapshots();
  }
}
