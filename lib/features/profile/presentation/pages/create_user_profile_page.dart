import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/core/utils/helpers/ui_helpers.dart';
import 'package:ewallet/core/utils/widgets/loader_widget.dart';
import 'package:ewallet/features/profile/presentation/blocs/user_profile_bloc.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserProfilePage extends StatelessWidget {
  const CreateUserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
            if (state is UserProfileFailure) {
              showCustomSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is CreateUserProfileSuccess) {
              return Text("User profile created!");
            }
            if (state is UserProfileInprogress) {
              return LoaderWidget();
            }
            if (state is UserProfileSuccess) {
              return Text("Profile already created");
            }
            if (state is UserProfileNotCreated) {
              return TextButton(
                onPressed: () {
                  context.read<UserProfileBloc>().add(
                    UserProfileCreation(
                      username: "A Likith Reddy",
                      dob: DateTime.now(),
                      sources: [
                        Source(
                          sourceId: "123",
                          name: "HDFC Bank",
                          money: Money.inRupees(35003),
                        ),
                      ],
                      incomeCategories: [
                        Category(
                          categoryId: '123',
                          iconKey: 'heartPulse',
                          categoryName: 'Health',
                          categoryType: CategoryType.income,
                        ),
                      ],
                      expenseCategories: [
                        Category(
                          categoryId: "1234",
                          iconKey: 'food',
                          categoryName: 'food',
                          categoryType: CategoryType.expense,
                        ),
                      ],
                    ),
                  );
                },
                child: Text("create profile"),
              );
            }
            return Text("Something wrong with profile!");
          },
        ),
      ),
    );
  }
}
