import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/core/firestore/firestore_collections.dart';

class UserRef {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static DocumentReference user(String uid) {
    return _db.collection(FirestoreCollections.users).doc(uid);
  }

  static CollectionReference sources(String uid) {
    return user(uid).collection(FirestoreCollections.sources);
  }
}
