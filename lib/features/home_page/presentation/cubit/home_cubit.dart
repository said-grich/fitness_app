import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/bloc_export.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initialState());


}
