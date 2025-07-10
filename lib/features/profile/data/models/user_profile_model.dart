import 'package:equatable/equatable.dart';
import 'package:ewallet/features/shared/data/models/category_model.dart';
import 'package:ewallet/features/shared/data/models/source_model.dart';

class UserProfileModel extends Equatable {
  final String userId;
  final String userName;
  final String dob;
  final List<SourceModel> sources;
  final List<CategoryModel> incomeCategories;
  final List<CategoryModel> expenseCategories;

  const UserProfileModel({
    required this.userId,
    required this.userName,
    required this.dob,
    required this.sources,
    required this.incomeCategories,
    required this.expenseCategories,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> doc) {
    return UserProfileModel(
      userId: doc['userId'] as String? ?? '',
      userName: doc['userName'] as String? ?? '',
      dob: doc['dob'] as String? ?? '',
      sources: (doc['sources'] as List<dynamic>? ?? [])
          .map((sourceModel) => SourceModel.fromJson(sourceModel))
          .toList(),
      incomeCategories: (doc['incomeCategories'] as List<dynamic>? ?? [])
          .map((categoryModel) => CategoryModel.fromJson(categoryModel))
          .toList(),
      expenseCategories: (doc['expenseCategories'] as List<dynamic>? ?? [])
          .map((categoryModel) => CategoryModel.fromJson(categoryModel))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'dob': dob,
      'sources': sources.map((sourceModel) => sourceModel.toJson()).toList(),
      'incomeCategories': incomeCategories
          .map((categoryModel) => categoryModel.toJson())
          .toList(),
      'expenseCategories': expenseCategories
          .map((categoryModel) => categoryModel.toJson())
          .toList(),
    };
  }

  @override
  List<Object?> get props => [
    userId,
    userName,
    dob,
    sources,
    incomeCategories,
    expenseCategories,
  ];
}
