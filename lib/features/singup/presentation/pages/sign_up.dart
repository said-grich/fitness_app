import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/core/widgets/main_button.dart';
import 'package:fitness_app/core/widgets/text_fild.dart';
import 'package:fitness_app/features/singup/domain/entities/user.dart';
import 'package:fitness_app/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController userName = TextEditingController();

  TextEditingController userPass = TextEditingController();

  TextEditingController userEmail = TextEditingController();

  TextEditingController userPh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
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
              textFild(
                controller: userName,
                image: 'user.svg',
                keyBordType: TextInputType.name,
                hintTxt: AppString.fullNameString,
              ),
              textFild(
                controller: userEmail,
                keyBordType: TextInputType.emailAddress,
                image: 'email.svg',
                hintTxt: AppString.emailString,
              ),
              textFild(
                controller: userPh,
                image: 'phone.svg',
                keyBordType: TextInputType.phone,
                hintTxt: AppString.phoneNumberString,
              ),
              textFild(
                controller: userPass,
                isObs: true,
                image: 'hide.svg',
                hintTxt: AppString.passwordString,
              ),
              const SpaceVH(height: 20.0),
              Mainbutton(
                onTap: () {
                  User user = User(
                      uid: "uid22222",
                      fullname: userName.text,
                      email: userEmail.text,
                      password: userPass.text);

                  context.read<SingupBloc>().add(OnSingUpEvent(user: user));
                },
                text: AppString.singUpString,
                btnColor: blueButton,
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
          ),
        ),
      ),
    );
  }
}
