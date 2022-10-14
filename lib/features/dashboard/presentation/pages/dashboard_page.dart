import 'package:fitness_app/core/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../../core/bloc_export.dart';
import '../../../../core/colors.dart';
import '../../../../core/test_style.dart';
import '../../../authentication/bloc/authentication_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppString.appTitle,
          style: headline.copyWith(
              fontStyle: FontStyle.italic, color: Colors.black, fontSize: 40),
        ),
        actions: <Widget>[
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return IconButton(
                key: const Key('homePage_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app, color: Colors.black),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AppUserLogoutRequested());
                },
              );
            },
          )
        ],
        systemOverlayStyle:
            SystemUiOverlayStyle.dark.copyWith(statusBarColor: grayback),
      ),
    );
  }
}
