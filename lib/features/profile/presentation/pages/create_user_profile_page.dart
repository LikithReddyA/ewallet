import 'package:ewallet/app/router/routes.dart';
import 'package:ewallet/core/utils/widgets/loader_widget.dart';
import 'package:ewallet/features/profile/presentation/blocs/user_profile_bloc.dart';
import 'package:ewallet/features/profile/presentation/wdigets/categories_step.dart';
import 'package:ewallet/features/profile/presentation/wdigets/personal_details_step.dart';
import 'package:ewallet/features/profile/presentation/wdigets/sources_step.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateUserProfilePage extends StatefulWidget {
  const CreateUserProfilePage({super.key});

  @override
  State<CreateUserProfilePage> createState() => _CreateUserProfilePageState();
}

class _CreateUserProfilePageState extends State<CreateUserProfilePage> {
  int _currentStep = 0;

  final TextEditingController nameController = TextEditingController();
  DateTime? pickedDate;

  List<Source> sources = [];
  List<Category> selectedIncomeCategories = [];
  List<Category> selectedExpenseCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is CreateUserProfileSuccess) {
            context.goNamed(Routes.home.name);
          }
        },
        builder: (context, state) {
          if (state is UserProfileNotCreated) {
            return Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep--);
                }
              },
              controlsBuilder: (context, details) {
                return buildControls(details);
              },
              steps: [
                Step(
                  title: Text("Personal Details"),
                  content: PersonalDetailsStep(
                    nameController: nameController,
                    pickedDate: pickedDate,
                    onDateChanged: (date) {
                      setState(() => pickedDate = date);
                    },
                  ),
                ),
                Step(
                  title: Text("Sources"),
                  content: SourcesStep(
                    sources: sources,
                    onSourceAdded: (source) {
                      setState(() => sources.add(source));
                    },
                  ),
                ),
                Step(
                  title: Text("Categories"),
                  content: CategoriesStep(
                    selectedIncomeCategories: selectedIncomeCategories,
                    selectedExpenseCategories: selectedExpenseCategories,
                    onIncomeChanged: (list) {
                      setState(() => selectedIncomeCategories = list);
                    },
                    onExpenseChanged: (list) {
                      setState(() => selectedExpenseCategories = list);
                    },
                  ),
                ),
              ],
            );
          } else if (state is UserProfileInprogress) {
            return LoaderWidget();
          } else {
            return Center(child: Text("User profile created!"));
          }
        },
      ),
    );
  }

  Widget buildControls(ControlsDetails details) {
    if (_currentStep == 0) {
      return TextButton(
        onPressed: () {
          if (nameController.text.isNotEmpty && pickedDate != null) {
            details.onStepContinue?.call();
          }
        },
        child: Text("Next"),
      );
    } else if (_currentStep == 2) {
      return Row(
        children: [
          TextButton(onPressed: details.onStepCancel, child: Text("Back")),
          TextButton(
            onPressed: () {
              if (sources.isNotEmpty &&
                  selectedIncomeCategories.isNotEmpty &&
                  selectedExpenseCategories.isNotEmpty) {
                final categories = selectedIncomeCategories;
                categories.addAll(selectedExpenseCategories);
                context.read<UserProfileBloc>().add(
                  UserProfileCreation(
                    username: nameController.text,
                    dob: pickedDate!,
                    sources: sources,
                    categories: categories,
                  ),
                );
              }
            },
            child: Text("Submit"),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          TextButton(
            onPressed: () {
              if (sources.isNotEmpty) {
                details.onStepContinue?.call();
              }
            },
            child: Text("Next"),
          ),
          TextButton(onPressed: details.onStepCancel, child: Text("Back")),
        ],
      );
    }
  }
}
