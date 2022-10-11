import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/core/widgets/main_button.dart';
import 'package:fitness_app/core/widgets/text_fild.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/cubits/login_cubits/login_cubit.dart';
import 'package:fitness_app/features/authentication/presentation/pages/signup_page.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:fitness_app/features/home_page/presentation/pages/home_page.dart';
import 'package:fitness_app/features/stepper_form/pages/stepper_page.dart';
import 'package:fitness_app/features/stepper_form/widgets/error_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>()),
            child: const LoginPage(),
          ));

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: grayback,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
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
            builder: (context, state) {
              return BlocProvider(
                create: (context) =>
                    LoginCubit(context.read<AuthenticationRepository>()),
                child: LoginForm(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController userName = TextEditingController();
  final TextEditingController userPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {}
      },
      child: Column(
        children: [
          const SpaceVH(height: 50.0),
           Text(
            AppString.welcomeBackString,
            style: headline1.copyWith(color: Colors.black),
          ),
          const SpaceVH(height: 10.0),
          const Text(
            AppString.pleaseSingInForm,
            style: headline3,
          ),
          const SpaceVH(height: 60.0),
          BlocBuilder<LoginCubit, LoginState>(builder: ((context, state) {
            return state.status == LoginStatus.error
                ? ErrorMessage(msg: state.errorMsg)
                : const SpaceVH(height: 0.0);
          })),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (priveus, current) => priveus.email != current.email,
            builder: (context, state) {
              return textFild(
                onChange: (email) {
                  context.read<LoginCubit>().emailChanged(email);
                },
                controller: userName,
                image: 'user.svg',
                hintTxt: AppString.fullNameString,
              );
            },
          ),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (priveus, current) =>
                priveus.password != current.password,
            builder: (context, state) {
              return textFild(
                controller: userPass,
                image: 'hide.svg',
                isObs: true,
                hintTxt: AppString.passwordString,
                onChange: (password) {
                  context.read<LoginCubit>().passwordChanged(password);
                },
              );
            },
          ),
          const SpaceVH(height: 10.0),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  AppString.forgotPasswordString,
                  style: headline3,
                ),
              ),
            ),
          ),
          const SpaceVH(height: 20.0),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return state.status == LoginStatus.submitting
                        ? const CircularProgressIndicator()
                        : Mainbutton(
                            onTap: () {
                              context.read<LoginCubit>().loginWithCridentials();
                            },
                            text: AppString.singInString,
                            btnColor: blueButton,
                          );
                  },
                ),
                const SpaceVH(height: 20.0),
                Mainbutton(
                  onTap: () {},
                  text: AppString.loginWithGoogleString,
                  image: 'google.png',
                  btnColor: bluelight,
                  txtColor: blackBG,
                ),
                const SpaceVH(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SignUpPage()));
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: AppString.dontHaveAnAccount,
                        style: headline.copyWith(
                          fontSize: 14.0,
                          color: Colors.black
                        ),
                      ),
                      TextSpan(
                        text: AppString.singUpString,
                        style: headlineDot.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
