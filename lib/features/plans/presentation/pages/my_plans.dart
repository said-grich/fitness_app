import 'package:avatar_view/avatar_view.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/features/plans/presentation/cubit/plans_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/bloc_export.dart';
import '../../../../core/colors.dart';

class MyPlans extends StatelessWidget {
  const MyPlans(
      {super.key,});
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlansCubit()..loadMyPlans(),
      child: BlocBuilder<PlansCubit, PlansState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: blueButton),
              title: Text(
                "اشتركاتي",
                style: headline.copyWith(fontSize: 20, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: blueButton,
            ),
            backgroundColor: grayback,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children:  state.myPlans
                          .map((e) => MyPlanCard(
                                imagPath: "",
                                comment: e.category,
                                name: e.name, 
                              ))
                          .toList(),
                      
                ),
              ),
            ),
           
          );
        },
      ),
    );
  }
}

class MyPlanCard extends StatelessWidget {
  const MyPlanCard({
    Key? key,
    required this.imagPath,
    required this.name,
    required this.comment,
  }) : super(key: key);
  final String? imagPath;
  final String name;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () {
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
