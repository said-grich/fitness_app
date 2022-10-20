// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

enum HomeStatus { initial, incomplte, succes, error, submiting }

class HomeState extends Equatable {
  final int selectedIndex;
  final List<DiscussionModel> discussionModel;
  final ProfileModel profile;
  final HomeStatus status;
  const HomeState({required this.profile, 
      required this.discussionModel,
      required this.selectedIndex,
      required this.status});
  factory HomeState.initialState() {
    return  HomeState(
        status: HomeStatus.initial, selectedIndex: 0, discussionModel: [], profile: ProfileModel.empty);
  }

  @override
  List<Object> get props => [status, selectedIndex];



  HomeState copyWith({
    int? selectedIndex,
    List<DiscussionModel>? discussionModel,
    ProfileModel? profile,
    HomeStatus? status,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      discussionModel: discussionModel ?? this.discussionModel,
      profile: profile ?? this.profile,
      status: status ?? this.status,
    );
  }
}
