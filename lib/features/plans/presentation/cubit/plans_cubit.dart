import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/plans/model/plane_model.dart';
import 'package:flutter/services.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit() : super(PlansState.initial());

  loadPlans() async {
    emit(state.copyWith(status: PlansStatus.submiting));
    List<PlanModel> plansList = [];
    final String dataString =
        await rootBundle.loadString('assets/data/plans.json');
    List data = await json.decode(dataString);
    for (var element in data) {
      plansList.add(PlanModel.fromJson(element));
    }
    emit(state.copyWith(plansList:  plansList));
  }
}
