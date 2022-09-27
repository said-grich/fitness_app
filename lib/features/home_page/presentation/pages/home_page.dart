import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return  Scaffold(
      appBar:  AppBar(
        title: const Text('الصفحة الرئيسية'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AuthenticationBloc>().add(AppUserLogoutRequested()),
          )
        ],
      ),
      
      body: const SafeArea(
          child: Center(
        child: Text("الصفحة الرئيسية"),
      )),
    );
  }
}
