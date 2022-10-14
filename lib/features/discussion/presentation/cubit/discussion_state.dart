// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discussion_cubit.dart';

enum DiscussionStatus { initial, submiting, succes, error }

class DiscussionState extends Equatable {
  final DiscussionStatus status;

  final String userId;
  final String title;
  final String desc;
  final String photourl;
  final String photoError;
  final List<DiscussionModel> disscutionList;

  const DiscussionState( {required  this.disscutionList, 
      required this.photoError,
      required this.userId,
      required this.title,
      required this.desc,
      required this.photourl,
      required this.status});

  factory DiscussionState.initial() {
    return const DiscussionState(
        status: DiscussionStatus.initial,
        desc: '',
        photourl: '',
        title: '',
        userId: '',
        photoError: '', 
        disscutionList: []);
  }

  @override
  List<Object> get props => [ disscutionList,status, userId, title, desc, photourl];

  DiscussionState copyWith({
    DiscussionStatus? status,
    String? userId,
    String? title,
    String? desc,
    String? photourl,
    String? photoError,
      final List<DiscussionModel>? disscutionList

  }) {
    return DiscussionState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      photourl: photourl ?? this.photourl,
      photoError: photoError ?? this.photoError, 
      disscutionList: disscutionList?? this.disscutionList,
    );
  }
}
