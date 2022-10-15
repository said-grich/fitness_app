import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/bloc_export.dart';
import '../../../../core/colors.dart';
import '../../../../core/test_style.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../home_page/presentation/widgets/carsoul_data_not_found.dart';
import '../../../home_page/presentation/widgets/cousale_data_found.dart';
import '../widgets/nav_darawer.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
    
    
        drawer: const NavDrawer(),
        appBar: AppBar(
    
           leading: Builder(
              builder: (context) => IconButton(
                  icon: Icon(Icons.menu , color: Colors.black),
                  onPressed: () {
                  Scaffold.of(context).openDrawer();
                  },
              )),
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
        body: BlocProvider(
          create: (context) => DashboardCubit()..loadCorousel(),
          child: SafeArea(child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
               if(state.status==DashboardStatus.submiting)
                  // ignore: curly_braces_in_flow_control_structures
                  if(state.discussionList.isNotEmpty) {
                    return CarouselSliderDataFound(state.discussionList);
                  } else {
                    return const CarouselLoading();
                  }
                else
                  if(state.discussionList.isNotEmpty) {
                    return CarouselSliderDataFound(state.discussionList);
                  } else {
                    return Container();
                  }
              },
          )),
        ),
      ),
    );
  }
}
