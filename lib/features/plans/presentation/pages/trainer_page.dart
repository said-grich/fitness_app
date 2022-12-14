import 'package:avatar_view/avatar_view.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/features/plans/model/plane_model.dart';
import 'package:fitness_app/features/plans/presentation/cubit/plans_cubit.dart';
import 'package:fitness_app/features/plans/presentation/pages/create_plan.dart';
import 'package:fitness_app/features/plans/presentation/pages/plan_details.dart';
import 'package:fitness_app/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/app_string.dart';
import '../../../../core/bloc_export.dart';
import '../../../../core/colors.dart';

class TrainerPlansPAge extends StatelessWidget {
  const TrainerPlansPAge(
      {super.key,
      required this.model,
      required this.type,
      required this.title});
  final ProfileModel model;
  final int type;
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlansCubit()..loadBytype(model.id),
      child: BlocBuilder<PlansCubit, PlansState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: blueButton),
              title: Text(
                title,
                style: headline.copyWith(fontSize: 20, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: blueButton,
            ),
            backgroundColor: grayback,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: type == 1
                      ? state.plansList1
                          .map((e) => PlanCard(
                                imagPath: model.photoUrl,
                                comment: e.category,
                                name: e.name, plan: e,
                                 trainerId: model,
                              ))
                          .toList()
                      : state.plansList2
                          .map((e) => PlanCard(
                                imagPath: model.photoUrl,
                                comment: e.category,
                                name: e.name, plan: e, trainerId: model,
                              ))
                          .toList(),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 50,
              hoverColor: Colors.red,
              autofocus: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreatePlan(
                            type: type,
                          )),
                );
              },
              tooltip: AppString.adddisscutionString,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    Key? key,
    required this.imagPath,
    required this.name,
    required this.comment,
    required this.plan, required this.trainerId,
  }) : super(key: key);
  final String? imagPath;
  final String name;
  final String comment;
  final PlanModel plan;
  final ProfileModel trainerId;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PlanDetails(plan: plan, trainerId: trainerId ,)));
          },
          child: Card(
            // ignore: sort_child_properties_last
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Expanded(
                          child: AvatarView(
                            radius: 40,
                            borderWidth: 3,
                            borderColor: whiteText,
                            avatarType: AvatarType.CIRCLE,
                            backgroundColor: Colors.transparent,
                            imagePath: imagPath ?? "assets/image/profile.png",
                            placeHolder: const Icon(
                              Icons.person,
                              size: 50,
                            ),
                            errorWidget: const Icon(
                              Icons.error,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                  title: Text(
                                    name,
                                    style: headline2.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    comment,
                                    style: headline3,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            elevation: 8,
            margin: const EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
