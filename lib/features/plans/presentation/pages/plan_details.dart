import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/plans/model/plane_model.dart';
import 'package:fitness_app/features/plans/presentation/pages/create_plan.dart';
import 'package:fitness_app/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/app_string.dart';
import '../../../../core/colors.dart';
import '../../../../core/space.dart';
import '../../../../core/test_style.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../profile/presentation/widgets/subtitle.dart';
import '../../../profile/presentation/widgets/text_fiald_custom.dart';
import '../cubit/plans_cubit.dart';

class PlanDetails extends StatelessWidget {
  const PlanDetails({super.key, required this.plan, required this.trainerId});

  final PlanModel plan;
  final ProfileModel trainerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle.light.copyWith(statusBarColor: blueButton),
          title: Text(
            plan.name,
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
              children: <Widget>[
                PlanDetailsForm(
                  plan: plan, trainerId: trainerId,
                )
              ],
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class PlanDetailsForm extends StatelessWidget {
  PlanDetailsForm({
    super.key,
    required this.plan,
    required this.trainerId,
  });
  final PlanModel plan;
  final ProfileModel trainerId;

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
              listener: (context, state) {},
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(children: [
                    const SpaceVH(
                      height: 20,
                    ),
                    ctextFild(image: '', initialValue: plan.name, subtitle: ''),
                    const SpaceVH(
                      height: 10,
                    ),
                    ctextFild(image: '', initialValue: plan.desc, subtitle: ''),
                    const SpaceVH(
                      height: 10,
                    ),
                    ctextFild(
                        image: '', initialValue: plan.category, subtitle: ''),
                    const SpaceVH(
                      height: 10,
                    ),
                    subTitle("${AppString.stpesString} :"),
                    const SpaceVH(
                      height: 4,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: LimitedBox(
                            maxHeight: 150,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: plan.steps.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ctextFild1(
                                    image: '',
                                    initialValue: "- ${plan.steps[index]}",
                                    subtitle: '',
                                  );
                                }))),
                    const SpaceVH(height: 5),
                    const SpaceVH(
                      height: 20,
                    ),
                    Mainbutton(
                        onTap: (() {
                          context.read<PlansCubit>().checkOutPlan(trainerId  , plan);
                          Navigator.pop(context);
                        }),
                        text: AppString.getString,
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
