import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/plans/model/plane_model.dart';
import 'package:fitness_app/features/profile/model/profile_model.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit() : super(PlansState.initial());

  loadPlans() async {
    emit(state.copyWith(status: PlansStatus.submiting));

    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;

    var user = await fireStore.collection('users').doc(auth?.uid).get();
    var tmp = user.data();

    List<PlanModel> plansModel = [];

    if (tmp != null) {
      List plans = tmp["plans"];
      for (var element in plans) {
        plansModel.add(PlanModel.fromJson(element));
      }
    }
  }

  titleChanged(value) {
    emit(state.copyWith(title: value));
  }

  descChanged(value) {
    emit(state.copyWith(desc: value));
  }

  categoryChanged(value) {
    emit(state.copyWith(category: value));
  }

  subMenuChange(value) {
    emit(state.copyWith(submenu: value));
  }

  stepOnchage(vlaue) {
    emit(state.copyWith(status: PlansStatus.submiting, step: ''));
    emit(state.copyWith(step: vlaue, status: PlansStatus.initial));
  }

  stepsAdd() {
    emit(state.copyWith(steps: List.from(state.steps)..add(state.step)));
  }

  stepsRemove(value) {
    emit(state.copyWith(steps: List.from(state.steps)..remove(value)));
  }

  submit(type) async {
    emit(state.copyWith(status: PlansStatus.submiting));
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;

    var oldData = await fireStore.collection('users').doc(auth?.uid).get();
    var tmp = oldData.data();
    if (tmp != null) {
      var tmpPlan = {
        "name": state.title,
        "desc": state.desc,
        "category": state.category,
        "steps": state.steps,
        "type": type
      };

      try {
        List oldPlans = tmp["plans"];
        oldPlans.add(tmpPlan);

        await fireStore
            .collection('users')
            .doc(auth?.uid)
            .update({"plans": oldPlans});
      } catch (_) {
        await fireStore.collection('users').doc(auth?.uid).update({
          "plans": [tmpPlan]
        });
      }
    }
  }

  loadBytype(id) async {
    emit(state.copyWith(status: PlansStatus.succes));
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    var oldData = await fireStore.collection('users').doc(id).get();
    var tmp = oldData.data();
    List<PlanModel> plansModel1 = [];
    List<PlanModel> plansModel2 = [];
    if (tmp != null) {
      List oldPlans = tmp["plans"];
      for (var element in oldPlans) {
        if (element["type"] == 1) {
          plansModel1.add(PlanModel.fromJson(element));
        } else {
          plansModel2.add(PlanModel.fromJson(element));
        }

        emit(state.copyWith(
            plansList1: plansModel1,
            plansList2: plansModel2,
            status: PlansStatus.succes));
      }
    }
  }

  loadAllTrainers() async {
    emit(state.copyWith(status: PlansStatus.submiting));
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;

    List<ProfileModel> listTrainers = [];
    var collection = await fireStore.collection('users').get().then(
          (res) => {
            res.docs.forEach((element) {
              var tmp = element.data();

              if (tmp["role"] == "trainer") {
                listTrainers.add(ProfileModel.fromJson(tmp));
              }
            })
          },
          onError: (e) => print("Error completing: $e"),
        );

    emit(state.copyWith(
        trainers_list: listTrainers, status: PlansStatus.succes));
  }

  checkOutPlan(ProfileModel trainerModel, plan) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;

    List<ProfileModel> listTrainers = [];
    var doc1 = await fireStore.collection('users').doc(trainerModel.id).get();
    var tmp = doc1.data();
    List<String?> custmorIds = [];
    var doc2 = await fireStore.collection('users').doc(auth?.uid).get();
    var tmp1 = doc2.data();
    List trainersIds = [];
    try {
      if (tmp != null) {
        custmorIds = tmp["customers"];
        if (auth?.uid != null) {
          custmorIds.add(auth?.uid);

          await fireStore
              .collection('users')
              .doc(trainerModel.id)
              .update({"customers": custmorIds});
        }
      }
    } catch (_) {
      await fireStore.collection('users').doc(trainerModel.id).update({
        "customers": [auth?.uid]
      });
    }

    try {
      if (tmp1 != null) {
        trainersIds = tmp1["trainers"];
        if (auth?.uid != null) {
          trainersIds
              .add({"trainer": trainerModel.toJson(), "plan": plan.toJson()});

          await fireStore
              .collection('users')
              .doc(auth?.uid)
              .update({"trainers": trainersIds});
        }
      }
    } catch (_) {
      await fireStore.collection('users').doc(auth?.uid).update({
        "trainers": [
          {"trainer": trainerModel.toJson(), "plan": plan.toJson()}
        ]
      });
    }
  }

  loadMyCustumers() async {
    emit(state.copyWith(status: PlansStatus.submiting));
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;

    List<ProfileModel> listTrainers = [];
    var doc1 = await fireStore.collection('users').doc(auth?.uid).get();
    var tmp = doc1.data();

    if (tmp != null) {
      List tmpList = tmp["customers"];

      print(tmpList);
      tmpList.forEach((element) async {
        var doc2 = await fireStore.collection('users').doc(element).get();
        var tmp3 = doc2.data();
        if (tmp3 != null) {
          print(tmp3);
          listTrainers.add(ProfileModel.fromJson(tmp3));
          emit(state.copyWith(
              myCustomersList: listTrainers, status: PlansStatus.succes));
        }
      });
    }
  }

  loadMyPlans() async {
    emit(state.copyWith(status: PlansStatus.submiting));
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;

    List<PlanModel> listPlans = [];
    var doc1 = await fireStore.collection('users').doc(auth?.uid).get();
    var tmp = doc1.data();

    if (tmp != null) {
      List tmpList = tmp["trainers"];

      tmpList.forEach((element) async {
        listPlans.add(PlanModel.fromJson(element["plan"]));
         emit(state.copyWith(myPlans: listPlans, status: PlansStatus.succes));
      });
    }
  }

loadMyTrainers() async {
    emit(state.copyWith(status: PlansStatus.submiting));
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    User? auth = FirebaseAuth.instance.currentUser;

    List<ProfileModel> listTrainer = [];
    var doc1 = await fireStore.collection('users').doc(auth?.uid).get();
    var tmp = doc1.data();

    if (tmp != null) {
      List tmpList = tmp["trainers"];

      tmpList.forEach((element) async {
        listTrainer.add(ProfileModel.fromJson(element["trainer"]));
         emit(state.copyWith(myTrainersList: listTrainer, status: PlansStatus.succes));
      });
    }
  }


}
