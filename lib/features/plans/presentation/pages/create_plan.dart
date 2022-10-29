import 'package:fitness_app/core/widgets/main_button.dart';
import 'package:fitness_app/features/plans/presentation/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/app_string.dart';
import '../../../../core/bloc_export.dart';
import '../../../../core/colors.dart';
import '../../../../core/space.dart';
import '../../../../core/test_style.dart';
import '../../../../core/widgets/text_fild.dart';
import '../../../discussion/presentation/widgets/describtion_field.dart';
import '../../../home_page/presentation/pages/home_page.dart';
import '../../../profile/presentation/widgets/subtitle.dart';
import '../cubit/plans_cubit.dart';

class CreatePlan extends StatelessWidget {
  const CreatePlan({super.key, required this.type});
  final int type;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlansCubit, PlansState>(
      listener: (context, state) {
        if (state.status == PlansStatus.succes) {
          Fluttertoast.showToast(
              msg: AppString.addSuccesString,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle.light.copyWith(statusBarColor: blueButton),
            title: Text(
              AppString.createPlan,
              style: headline.copyWith(fontSize: 20, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: blueButton,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[AddPlanForm(type: type,)],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class AddPlanForm extends StatelessWidget {
  AddPlanForm({super.key, required this.type});
  final int type;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlansCubit(),
      child: Container(
        decoration: const BoxDecoration(color: grayback),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            BlocConsumer<PlansCubit, PlansState>(
              listener: (context, state) {
                if (state.status == PlansStatus.succes) {
                  Fluttertoast.showToast(
                      msg: AppString.addSuccesString,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(children: [
                    const SpaceVH(
                      height: 20,
                    ),
                    textFild(
                        hintTxt: AppString.titleString,
                        image: '',
                        controller: titleController,
                        onChange: (String value) {
                          context.read<PlansCubit>().titleChanged(value);
                        }),
                    const SpaceVH(
                      height: 10,
                    ),
                    subTitle("${AppString.categoryString} :"),
                    const SpaceVH(
                      height: 5,
                    ),
                    dropDown(
                        items: AppString.plansArray,
                        vlaue: state.category,
                        onChange: ((value) {
                          context.read<PlansCubit>().categoryChanged(value);
                        })),
                    textFormFild(
                        hintTxt: AppString.descriptionString,
                        image: '',
                        controller: titleController,
                        onChange: (String value) {
                          context.read<PlansCubit>().descChanged(value);
                        }),
                    subTitle("${AppString.stpesString} :"),
                    const SpaceVH(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: LimitedBox(
                        maxHeight: 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: state.steps.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              height: 60,
                              child: Slidable(
                                // Specify a key if the Slidable is dismissible.
                                key: UniqueKey(),

                                // The start action pane is the one at the left or the top side.
                                startActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),

                                  // A pane can dismiss the Slidable.
                                  dismissible: DismissiblePane(onDismissed: () {
                                    context
                                        .read<PlansCubit>()
                                        .stepsRemove(state.steps[index]);
                                  }),

                                  // All actions are defined in the children parameter.
                                  children: [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: (context) {},
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      icon: Icons.delete,
                                      label: 'ازالة',
                                    ),
                                  ],
                                ),

                                // The end action pane is the one at the right or the bottom side.

                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: ctextFild1(
                                  image: '',
                                  initialValue: "- ${state.steps[index]}",
                                  subtitle: '',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SpaceVH(height: 5),
                    textFormFild(
                        hintTxt: AppString.addStepString,
                        image: '',
                        controller: titleController,
                        onChange: (String value) {
                          context.read<PlansCubit>().stepOnchage(value);
                        }),
                    GestureDetector(
                      onTap: () async {
                        await context.read<PlansCubit>().stepsAdd();
                      },
                      child: Container(
                        width: 150,
                        height: 50.0,
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: blackBG,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "اضافة",
                              style: headline2.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SpaceVH(
                      height: 20,
                    ),
                    Mainbutton(
                        onTap: (() {
                          context.read<PlansCubit>().submit(type);

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomePage(pgaenumber: 1)),
                              (Route<dynamic> route) => false,
                            );
                        }),
                        text: AppString.confirmeString,
                        btnColor: blueButton),
                    const SpaceVH(
                      height: 10,
                    ),
                  ]),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget ctextFild1({
  required String image,
  required String initialValue,
  required String subtitle,
}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: blackTextFild,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: sized_box_for_whitespace
          Container(
              width: 240.0,
              child: Row(
                children: [
                  const Icon(Icons.check),
                  Text(
                    "$subtitle $initialValue",
                    style: headline2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ],
      ),
    ),
  );
}
