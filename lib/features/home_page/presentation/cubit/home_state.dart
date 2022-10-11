// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

enum HomeStatus { initial, incomplte, succes, error,submiting }

class HomeState extends Equatable {
  final HomeStatus status;
  const HomeState({required this.status});
  factory HomeState.initialState() {
    return const HomeState(status: HomeStatus.initial);
  }

  @override
  List<Object> get props => [status];

  HomeState copyWith({
    HomeStatus? status,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }
}
