import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/discussion/model/discussion_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  Future<void> loadCorousel() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    emit(state.copyWith(status: DashboardStatus.submiting));
    await _fireStore.collection("postes").get().then(
          (res) => {
            res.docs.forEach((element) {
              var tmp = element.data();

              emit(state.copyWith(
                  discussionList: List.from(state.discussionList)
                    ..add(DiscussionModel.fromJson(tmp))));
            })
          },
          onError: (e) => print("Error completing: $e"),
        );
  }
}
