// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discussion_detaills_cubit.dart';
enum DiscussionDetaillesStatus { initial, submiting, succes, error }

class DiscussionDetaillsState extends Equatable {
  const DiscussionDetaillsState({required this.comments, 
      required this.profileModel,
      required this.status,
      required this.comment,
      required this.commentError});
  final ProfileModel profileModel;
  final DiscussionDetaillesStatus status;
  final String comment;
  final String commentError;
  final List<CommnetModel>    comments;

  factory DiscussionDetaillsState.initial() {
    return DiscussionDetaillsState(
        profileModel: ProfileModel.empty,
        status: DiscussionDetaillesStatus.initial,
        comment: '',
        commentError: '', comments: []);
  }

  @override
  List<Object> get props => [profileModel, profileModel, comments ,comment, commentError];

  DiscussionDetaillsState copyWith({
    ProfileModel? profileModel,
    DiscussionDetaillesStatus? status,
    String? comment,
    String? commentError,
    List<CommnetModel>?    comments
  }) {
    return DiscussionDetaillsState(
      profileModel: profileModel ?? this.profileModel,
      status: status ?? this.status,
      comment: comment ?? this.comment,
      commentError: commentError ?? this.commentError,
       comments: comments ?? this.comments,
    );
  }
}
