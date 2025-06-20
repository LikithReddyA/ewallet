import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallet_repository/src/models/models.dart';
import 'package:wallet_repository/src/wallet_repo.dart';

class WalletFirebaseRepository extends WalletRepo {
  final FirebaseFirestore _firebaseFirestore;

  WalletFirebaseRepository({FirebaseFirestore? firebaseFirestore})
    : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  CollectionReference get profilesCollection =>
      _firebaseFirestore.collection("profiles");
  @override
  Future<void> addUserProfile(UserProfile userProfile, List<Bank> banks) async {
    await profilesCollection
        .doc(userProfile.uid)
        .set(userProfile.toEntity().toDocument());

    for (var bank in banks) {
      await profilesCollection
          .doc(userProfile.uid)
          .collection("banks")
          .add(bank.toEntity().toDocument());
    }
  }

  @override
  Future<bool> isProfileCreated(String uid) async {
    try {
      final snapshot = await profilesCollection.doc(uid).get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        return data?["isProfileCompleted"] == true;
      } else {
        return false;
      }
    } catch (e) {
      //TODO: Handle the error catching more efficiently
      rethrow;
    }
  }
}
