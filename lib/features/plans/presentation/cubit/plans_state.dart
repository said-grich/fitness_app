// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'plans_cubit.dart';

enum PlansStatus { initial, submiting, succes, error }

class PlansState extends Equatable {
  final PlansStatus status;
  final List<PlanModel> plansList;
  const PlansState({required this.status, required this.plansList});

  factory PlansState.initial() {
    return const PlansState(plansList: [], status:  PlansStatus.initial);
  }

  @override
  List<Object> get props => [plansList ,status];

  

  PlansState copyWith({
    PlansStatus? status,
    List<PlanModel>? plansList,
  }) {
    return PlansState(
      status: status ?? this.status,
      plansList: plansList ?? this.plansList,
    );
  }
}
