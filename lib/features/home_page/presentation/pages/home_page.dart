import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/presentation/pages/login_page.dart';
import 'package:fitness_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:fitness_app/features/discussion/presentation/pages/discussion_page.dart';
import 'package:fitness_app/features/home_page/presentation/cubit/home_cubit.dart';
import 'package:fitness_app/features/plans/presentation/pages/plans_page.dart';
import 'package:fitness_app/features/profile/presentation/pages/profile_page.dart';
import 'package:fitness_app/features/stepper_form/pages/stepper_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int pgaenumber;
 

  const HomePage({super.key, required this.pgaenumber});
  static Page page() => const MaterialPage<void>(child: HomePage(pgaenumber: 0,));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AppStatus.authenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage( pgaenumber: 0,)),
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
      builder: (context, state) {
        int selectedIndex = 0;
        return BlocProvider(
          create: (context) => HomeCubit()..setindex(pgaenumber),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
                 List<Widget> pages = <Widget>[
     DashboardPage(model: state.profile,),
    PlansPage(model: state.profile,),
    const DiscussionPage(),
    const ProfilePage(),
  ];
              return Scaffold(
                  backgroundColor: grayback,
                  bottomNavigationBar: NavigationBarTheme(
                      data: NavigationBarThemeData(
                        indicatorColor: blueButton,
                        labelTextStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 14.0),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                          ),
                          child: NavigationBar(
                              elevation: 100,
                              labelBehavior:
                                  NavigationDestinationLabelBehavior.alwaysHide,
                              height: 70,
                              backgroundColor: Colors.white,
                              selectedIndex: state.selectedIndex,
                              onDestinationSelected: (index) {
                                context
                                    .read<HomeCubit>()
                                    .onDestinationSelected(index);
                              },
                              destinations: const [
                                NavigationDestination(
                                  icon: Icon(Icons.home_outlined),
                                  label: 'Home',
                                  selectedIcon: Icon(
                                    Icons.home_filled,
                                  ),
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.date_range_outlined),
                                  label: AppString.plansString,
                                  selectedIcon: Icon(Icons.date_range_sharp),
                                ),
                                NavigationDestination(
                                  icon: Icon(Icons.email_outlined),
                                  label: 'Favorites',
                                  selectedIcon: Icon(
                                    Icons.email,
                                  ),
                                ),
                                NavigationDestination(
                                    icon: Icon(
                                      Icons.person_outline,
                                    ),
                                    selectedIcon: Icon(Icons.person),
                                    label: AppString.profileString),
                              ]),
                        ),
                      )),
                  body: pages.elementAt(state.selectedIndex));
            },
          ),
        );
      },
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return const Center(
          child: Text("test"),
        );
      },
    );
  }
}
