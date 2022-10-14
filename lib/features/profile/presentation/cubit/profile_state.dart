// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
part of 'profile_cubit.dart';

enum ProfileStatus { initial, incomplte, succes, error, submiting }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileModel profileModel;

  const ProfileState({required this.status, required this.profileModel});

  factory ProfileState.InitialState() {
    return  ProfileState(
        status: ProfileStatus.initial, profileModel: ProfileModel.empty);
  }
  @override
  List<Object> get props => [status, profileModel];

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profileModel,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}
