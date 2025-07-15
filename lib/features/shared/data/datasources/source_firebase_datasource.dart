import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/shared/data/datasources/source_datasource.dart';
import 'package:ewallet/features/shared/data/models/source_model.dart';

class SourceFirebaseDatasource implements SourceDatasource {
  final FirebaseFirestore firebaseFirestore;

  SourceFirebaseDatasource({required this.firebaseFirestore});

  @override
  Future<void> addSource(SourceModel source, String userId) async {
    try {
      final userProfileRef = firebaseFirestore
          .collection("profiles")
          .doc(userId);
      final userProfile = await userProfileRef.get();
      if (userProfile.exists) {
        await userProfileRef
            .collection("sources")
            .doc(source.sourceId)
            .set(source.toJson(), SetOptions(merge: false));
        throw FirebaseException(
          plugin: "FirebaseFirestore",
          code: "user-profile-doesn't-exists",
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SourceModel> getSourceById(String sourceId, String userId) async {
    try {
      final sourceDoc = await firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("sources")
          .doc(sourceId)
          .get();

      if (!sourceDoc.exists) {
        throw FirebaseException(plugin: "Firestore", code: "source-not-found");
      }

      return SourceModel.fromJson(sourceDoc.data()!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SourceModel>> getAllSources(String userId) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("sources")
          .get();

      return querySnapshot.docs
          .map((doc) => SourceModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addBalance(
    String userId,
    String sourceId,
    int amountInPaise,
  ) async {
    try {
      await firebaseFirestore.runTransaction((transaction) async {
        final sourceRef = firebaseFirestore
            .collection("profiles")
            .doc(userId)
            .collection("sources")
            .doc(sourceId);

        final snapshot = await transaction.get(sourceRef);
        final data = snapshot.data();
        final currentAmount = data?["amountInPaise"] ?? 0;
        final updatedAmount = currentAmount + amountInPaise;

        transaction.update(sourceRef, {"amountInPaise": updatedAmount});
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> subtractBalance(
    String userId,
    String sourceId,
    int amountInPaise,
  ) async {
    try {
      await firebaseFirestore.runTransaction((transaction) async {
        final sourceRef = firebaseFirestore
            .collection("profiles")
            .doc(userId)
            .collection("sources")
            .doc(sourceId);

        final snapshot = await transaction.get(sourceRef);
        final data = snapshot.data();
        final currentAmount = data?["amountInPaise"] ?? 0;
        final updatedAmount = currentAmount - amountInPaise;
        if (updatedAmount < 0) {
          throw FirebaseException(
            plugin: "FirebaseFirestore",
            code: "invalid-amount-transaction",
          );
        }

        transaction.update(sourceRef, {"amountInPaise": updatedAmount});
      });
    } catch (e) {
      rethrow;
    }
  }
}
