import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'discussion_state.dart';

class DiscussionCubit extends Cubit<DiscussionState> {
  DiscussionCubit() : super(DiscussionInitial());
}
