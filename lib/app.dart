import 'package:fitness_app/config/routes/routrs.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/style.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/presentation/pages/login_page.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:fitness_app/features/home_page/presentation/pages/home_page.dart';
import 'package:flow_builder/flow_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/stepper_form/pages/stepper_page.dart';

class FitnessApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  const FitnessApp(
      {super.key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _authenticationRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthenticationBloc(
                  authenticationRepository: _authenticationRepository),
            ),
          ],
          child: BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationRepository: _authenticationRepository),
            child: const AppView(),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light
  ));
    return MaterialApp(
      
      title: 'Finess App',
      debugShowCheckedModeBanner: false,
      theme: Stlyes.themeData(),
      home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
           print(state);
        if (state.status == AppStatus.authenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
          );
        } else if (state.status == AppStatus.incomplete) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const StepperPage()),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        }
          },
          child: const LoginPage()),
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
