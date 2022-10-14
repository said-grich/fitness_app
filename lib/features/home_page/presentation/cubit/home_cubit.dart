import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/bloc_export.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initialState());

  onDestinationSelected(index) {
    emit(state.copyWith(status: HomeStatus.submiting));

    emit(state.copyWith(status: HomeStatus.succes, selectedIndex: index));
  }

  printss() {
    print("tettette");
  }
}
