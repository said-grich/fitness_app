// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'plans_cubit.dart';

enum PlansStatus { initial, submiting, succes, error }

class PlansState extends Equatable {
  final PlansStatus status;
  final List<PlanModel> plansList1;
  final List<PlanModel> plansList2;
  final List<PlanModel> myPlans;
  final String title;
  final String desc;
  final String step;
  final String category;
  final List<String> steps;
  final List<ProfileModel> trainers_list;
  final List<ProfileModel> myTrainersList;
  final List<ProfileModel> myCustomersList;
  final String submenu;
  

  const PlansState({ required this.myTrainersList,   required  this.myPlans,   required this.myCustomersList,  required this.submenu, 
    required this.trainers_list,
    required this.plansList1,
    required this.plansList2,
    required this.step,
    required this.title,
    required this.desc,
    required this.category,
    required this.steps,
    required this.status,
  });

  factory PlansState.initial() {
    return PlansState(
        plansList1: const [],
        plansList2: const [],
        status: PlansStatus.initial,
        category: AppString.plansArray[0],
        desc: '',
        title: '',
        steps: const [],
        step: '',
        trainers_list: [], submenu: '', myCustomersList: [], myPlans: [], myTrainersList: []);
  }
  @override
  List<Object> get props => [
        plansList1,
        plansList2,
        trainers_list,
        status,
        title,
        desc,
        category,
        step,
        steps,
        submenu,
        myCustomersList,
        myPlans,
        myTrainersList
      ];

  

  PlansState copyWith({
    PlansStatus? status,
    List<PlanModel>? plansList1,
    List<PlanModel>? plansList2,
    List<PlanModel>? myPlans,
    String? title,
    String? desc,
    String? step,
    String? category,
    List<String>? steps,
    List<ProfileModel>? trainers_list,
    List<ProfileModel>? myCustomersList,
    List<ProfileModel>? myTrainersList,
    String? submenu,
  }) {
    return PlansState(
      status: status ?? this.status,
      plansList1: plansList1 ?? this.plansList1,
      plansList2: plansList2 ?? this.plansList2,
      myPlans: myPlans ?? this.myPlans,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      step: step ?? this.step,
      category: category ?? this.category,
      steps: steps ?? this.steps,
      trainers_list: trainers_list ?? this.trainers_list,
      myCustomersList: myCustomersList ?? this.myCustomersList,
      myTrainersList: myTrainersList ?? this.myTrainersList,
      submenu: submenu ?? this.submenu,
    );
  }
}
