import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/expense/data/datasources/expense_datasource.dart';
import 'package:ewallet/features/expense/data/models/expense_model.dart';

class FirebaseExpenseDatasource implements ExpenseDatasource {
  final FirebaseFirestore firebaseFirestore;

  FirebaseExpenseDatasource({required this.firebaseFirestore});

  @override
  Future<void> addExpense(String userId, ExpenseModel expenseModel) async {
    try {
      final userProfileRef = firebaseFirestore
          .collection("profiles")
          .doc(userId);
      final userProfile = await userProfileRef.get();
      if (userProfile.exists) {
        await userProfileRef
            .collection("expenseTransactions")
            .doc(expenseModel.id)
            .set(expenseModel.toJson());
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

  @override
  Future<List<ExpenseModel>> fetchAllExpenses(String userId) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("expenseTransactions")
          .get();

      return querySnapshot.docs
          .map((doc) => ExpenseModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
