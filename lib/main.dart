import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/style.dart';
import 'package:fitness_app/features/login/presentation/pages/login_page.dart';
import 'package:fitness_app/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:fitness_app/features/singup/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: BlocProvider(
        create: (context) => SingupBloc(),
        child: MaterialApp(
          title: 'Finess App',
          debugShowCheckedModeBanner: false,
          theme: Stlyes.themeData(),
          home: LoginPage(),
        ),
      ),
    );
  }
}
