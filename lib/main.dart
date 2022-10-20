import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/app.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  return HydratedBlocOverrides.runZoned(() async {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    await authenticationRepository.user.first;
    runApp(FitnessApp(authenticationRepository: authenticationRepository));
  },
  storage: storage
  
  
  );
}
