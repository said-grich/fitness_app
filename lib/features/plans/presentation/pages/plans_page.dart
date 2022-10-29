import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/features/plans/presentation/pages/my_trainers_list.dart';
import 'package:fitness_app/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/bloc_export.dart';
import '../../../../core/test_style.dart';
import '../../../discussion/presentation/pages/discussion_page.dart';
import '../cubit/plans_cubit.dart';
import '../widgets/drop_down.dart';
import '../widgets/list_card.dart';
import 'create_plan.dart';
import 'my_custumers.dart';
import 'my_plans.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key, required this.model, required this.type});
  final ProfileModel model;
  final int type;

  @override
  Widget build(BuildContext context) {
    var items = [
      PlanInfo('خططي الغدائية', const Color(0xff6DC8F3),
          const Color(0xff73A1F9), 4.4, '', '', 'diet.png', 1),
      PlanInfo('خططي الرياضية', const Color(0xffFFB157),
          const Color(0xffFFA057), 3.7, '', '', 'fitness.png', 2),
    ];

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle.light.copyWith(statusBarColor: blueButton),
        title: Text(
          AppString.plansString,
          style: headline.copyWith(fontSize: 20, color: Colors.white),
        ),
        leading:  BlocBuilder<PlansCubit, PlansState>(
            builder: (context, state) {
              return type == 0 ? IconButton(
                  key: const Key('homePage_logout_iconButton'),
                  icon: const Icon(Icons.person, color: Colors.white),
                  alignment: Alignment.centerRight,
                  onPressed: () {

 Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const MyTrainersList(type: 0,)));
                    }): const SpaceVH(height: 0, width: 0,) ;

                  }
                  
                  
                  ),
        actions: [
          BlocBuilder<PlansCubit, PlansState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  key: const Key('homePage_logout_iconButton'),
                  icon: const Icon(Icons.message, color: Colors.white),
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    if (type == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyCustomersList(
                                type: type,
                              )));
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyPlans()));
                    }
                  },
                ),
              );
            },
          ),
         
           
        ],
        
        centerTitle: true,
        backgroundColor: blueButton,
      ),
      body: CardPlansList(
        items: items,
        borderRadius: 24,
        model: model,
        loginUserType: type,
      ),
    );
  }
}
