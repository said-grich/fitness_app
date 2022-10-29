import 'package:avatar_view/avatar_view.dart';
import 'package:fitness_app/features/plans/presentation/pages/trainer_page.dart';
import 'package:fitness_app/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/bloc_export.dart';
import '../../../../core/colors.dart';
import '../../../../core/test_style.dart';
import '../cubit/plans_cubit.dart';

class TrainersList extends StatelessWidget {
  const TrainersList({super.key, required this.type});
  final int type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlansCubit()..loadAllTrainers(),
      child: BlocBuilder<PlansCubit, PlansState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: blueButton),
              title: Text(
                "قائمة المدربين",
                style: headline.copyWith(fontSize: 20, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: blueButton,
            ),
            backgroundColor: grayback,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                    children: state.trainers_list
                        .map((e) => TrainsCard(
                              imagPath: e.photoUrl,
                              comment: e.email ?? "",
                              name: e.fullname ?? "",
                              model: e,
                              type: type,
                            ))
                        .toList()),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrainsCard extends StatelessWidget {
  const TrainsCard({
    Key? key,
    required this.imagPath,
    required this.name,
    required this.comment,
    required this.model,
    required this.type,
  }) : super(key: key);
  final String? imagPath;
  final String name;
  final String comment;
  final ProfileModel model;
  final int type;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TrainerPlansPAge(
                      model: model,
                      title:model.fullname ?? " ...",
                      type: type,
                    )));
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
