import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/income/data/datasources/income_datasource.dart';
import 'package:ewallet/features/income/data/models/income_model.dart';

class FirebaseIncomeDatasource implements IncomeDatasource {
  final FirebaseFirestore firebaseFirestore;

  FirebaseIncomeDatasource({required this.firebaseFirestore});

  @override
  Future<void> addIncome(String userId, IncomeModel incomeModel) async {
    try {
      final userProfileRef = firebaseFirestore
          .collection("profiles")
          .doc(userId);
      final userProfile = await userProfileRef.get();
      if (userProfile.exists) {
        await userProfileRef
            .collection("incomeTransactions")
            .doc(incomeModel.id)
            .set(incomeModel.toJson());
      } else {
        throw FirebaseException(
          plugin: "FirebaseFirestore",
          code: "user-doesn't-exists",
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
