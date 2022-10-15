// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, incomplte, succes, error, submiting }

class DashboardState extends Equatable {
  const DashboardState({required this.status, required this.discussionList});

  final DashboardStatus status;
  final List<DiscussionModel> discussionList;
  factory DashboardState.initial() {
    return const DashboardState(discussionList: [], status: DashboardStatus.initial,  );
  }

  @override
  List<Object> get props => [discussionList ,status];


  DashboardState copyWith({
    DashboardStatus? status,
    List<DiscussionModel>? discussionList,
  }) {
    return DashboardState(
      status: status ?? this.status,
      discussionList: discussionList ?? this.discussionList,
    );
  }
}
