import 'package:fitness_app/config/routes/routrs.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/style.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';

import 'package:flutter/material.dart';

class FitnessApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  const FitnessApp(
      {super.key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: MaterialApp(
            title: 'Finess App',
            debugShowCheckedModeBanner: false,
            theme: Stlyes.themeData(),
            home: BlocProvider(
        create: (_) => AuthenticationBloc(authenticationRepository: _authenticationRepository),
        child: Builder(
          builder: (context) {
            return FlowBuilder<AppStatus>(
                    state: context.select((AuthenticationBloc bloc) => bloc.state.status ),
                    onGeneratePages: onGenerateAppViewPages,
                  );
          }
        )
            ),
          ),
        );
  }
}

// final _router = GoRouter(
//   routes: [
//     GoRoute(path: Routes.home, builder: (context, state) => LoginPage()),
//     GoRoute(path: Routes.home, builder: (context, state) => LoginPage()),
//     GoRoute(path: Routes.home, builder: (context, state) => SignUpPage()),
//   ],
// );

// class Routes {
//   static const signup = '/signup';
//   static const login = '/login';
//   static const home = '/';
// }
