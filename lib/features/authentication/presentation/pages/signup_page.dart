import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/core/widgets/main_button.dart';
import 'package:fitness_app/core/widgets/text_fild.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/cubits/singup_cubits/singup_cubit_cubit.dart';
import 'package:fitness_app/features/authentication/presentation/pages/login_page.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:fitness_app/features/home_page/presentation/pages/home_page.dart';
import 'package:fitness_app/features/stepper_form/pages/stepper_page.dart';
import 'package:fitness_app/features/stepper_form/widgets/error_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
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
            child: BlocProvider(
              create: (context) =>
                  SingupCubit(context.read<AuthenticationRepository>()),
              child: SingupForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class SingupForm extends StatelessWidget {
  SingupForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController userName = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPh = TextEditingController();
  final TextEditingController userPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SpaceVH(height: 50.0),
        const Text(
          AppString.singUpString,
          style: headline1,
        ),
        const SpaceVH(height: 10.0),
        const Text(
          AppString.pleaseFileForm,
          style: headline3,
        ),
        const SpaceVH(height: 60.0),
        BlocBuilder<SingupCubit, SingupState>(
          buildWhen: ((previous, current) => previous.email != current.email),
          builder: (context, state) {
            return textFild(
              controller: userEmail,
              keyBordType: TextInputType.emailAddress,
              image: 'email.svg',
              hintTxt: AppString.emailString,
              onChange: (value) {
                context.read<SingupCubit>().emailChanged(value);
              },
            );
          },
        ),
        BlocBuilder<SingupCubit, SingupState>(builder: ((context, state) {
          return state.status == SingupStatus.error &&
                  state.emailMsgError.isNotEmpty
              ? ErrorMessage(msg: state.emailMsgError)
              : const SpaceVH(height: 0.0);
        })),
        BlocBuilder<SingupCubit, SingupState>(
          builder: (context, state) {
            return textFild(
              controller: userPass,
              isObs: true,
              image: 'hide.svg',
              hintTxt: AppString.passwordString,
              onChange: (value) {
                context.read<SingupCubit>().passwordChanged(value);
              },
            );
          },
        ),
        BlocBuilder<SingupCubit, SingupState>(builder: ((context, state) {
          return state.status == SingupStatus.error &&
                  state.passwordMsgError.isNotEmpty
              ? ErrorMessage(msg: state.passwordMsgError)
              : const SpaceVH(height: 0.0);
        })),
        const SpaceVH(height: 20.0),
        BlocBuilder<SingupCubit, SingupState>(
          builder: (context, state) {
            return state.status == SingupStatus.submitting
                ? const CircularProgressIndicator()
                : Mainbutton(
                    onTap: () async {
                      await context
                          .read<SingupCubit>()
                          .singupWithEmailAndPassword();
                      // ignore: use_build_context_synchronously
                      context.read<AuthenticationBloc>().add(AppUserSingUp());
                    },
                    text: AppString.singUpString,
                    btnColor: blueButton,
                  );
          },
        ),
        const SpaceVH(height: 20.0),
        Mainbutton(
          onTap: () {},
          text: 'Sign in with google',
          image: 'google.png',
          btnColor: white,
          txtColor: blackBG,
        ),
        const SpaceVH(height: 20.0),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: AppString.haveAnAccountString,
                style: headline.copyWith(
                  fontSize: 14.0,
                ),
              ),
              TextSpan(
                text: AppString.singInString,
                style: headlineDot.copyWith(
                  fontSize: 14.0,
                ),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
