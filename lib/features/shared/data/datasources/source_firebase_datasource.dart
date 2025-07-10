import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/shared/data/datasources/source_datasource.dart';
import 'package:ewallet/features/shared/data/models/source_model.dart';

class SourceFirebaseDatasource implements SourceDatasource {
  final FirebaseFirestore firebaseFirestore;

  SourceFirebaseDatasource({required this.firebaseFirestore});
  @override
  Future<SourceModel> getSourceById(String sourceId, String userId) async {
    try {
      final userProfile = await firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .get();
      final List<dynamic> categoriesJson = userProfile.get("sources");
      final List<SourceModel> categories = categoriesJson
          .map((doc) => SourceModel.fromJson(doc))
          .toList();
      return categories.firstWhere((element) => element.sourceId == sourceId);
    } catch (e) {
      rethrow;
    }
  }
}
