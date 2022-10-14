// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discussion_detaills_cubit.dart';

class DiscussionDetaillsState extends Equatable {
  const DiscussionDetaillsState(
      {required this.profileModel,
      required this.status,
      required this.comment,
      required this.commentError});
  final ProfileModel profileModel;
  final DiscussionDetaillesStatus status;
  final String comment;
  final String commentError;

  factory DiscussionDetaillsState.initial() {
    return DiscussionDetaillsState(
        profileModel: ProfileModel.empty,
        status: DiscussionDetaillesStatus.initial,
        comment: '',
        commentError: '');
  }

  @override
  List<Object> get props => [profileModel, profileModel, comment, commentError];

  DiscussionDetaillsState copyWith({
    ProfileModel? profileModel,
    DiscussionDetaillesStatus? status,
    String? comment,
    String? commentError,
  }) {
    return DiscussionDetaillsState(
      profileModel: profileModel ?? this.profileModel,
      status: status ?? this.status,
      comment: comment ?? this.comment,
      commentError: commentError ?? this.commentError,
    );
  }
}
