import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/app.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:fitness_app/firebase_options.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(() async{

      WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthenticationRepository authenticationRepository = AuthenticationRepository();
    await authenticationRepository.user.first;
  runApp(FitnessApp(authenticationRepository: authenticationRepository));
  });

}
