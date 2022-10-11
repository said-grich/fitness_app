import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/presentation/pages/login_page.dart';
import 'package:fitness_app/features/home_page/presentation/cubit/home_cubit.dart';
import 'package:fitness_app/features/stepper_form/pages/stepper_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
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
      builder: (context, state) {
          int selectedIndex = 0;

        return Scaffold(
          backgroundColor: grayback,
          appBar: AppBar(
                backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true, 
            
            title:  Text(AppString.appTitle,style: headline.copyWith(fontStyle:FontStyle.italic ,color: Colors.black,fontSize: 40),),
            actions: <Widget>[
              IconButton(
                key: const Key('homePage_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app,color:Colors.black),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AppUserLogoutRequested());
                },
              )
            ], systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: grayback),
          ),
          bottomNavigationBar:  NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor:blueButton ,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: NavigationBar(
            elevation: 10,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                height: 70,
                backgroundColor: Colors.white,
                
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
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
                    icon: Icon(Icons.email_outlined),
                    label: 'Email',
                    selectedIcon: Icon(Icons.email),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_outline),
                    label: 'Favorites',
                    selectedIcon: Icon(
                      Icons.favorite,
                    ),
                  ),
                  NavigationDestination(
                      icon: Icon(
                        Icons.settings_outlined,
                      ),
                      selectedIcon: Icon(Icons.settings),
                      label: 'Settings'),
                ]),
          )),
          body: BlocProvider(
            create: (context) => HomeCubit(),
            child: const HomeBody(),
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
