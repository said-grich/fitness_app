import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/core/widgets/main_button.dart';
import 'package:fitness_app/core/widgets/text_fild.dart';
import 'package:fitness_app/features/singup/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

  TextEditingController userName = TextEditingController();

  TextEditingController userPass = TextEditingController();

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
                AppString.welcomeBackString,
                style: headline1,
              ),
              const SpaceVH(height: 10.0),
              const Text(
                AppString.pleaseSingUpForm,
                style: headline3,
              ),
              const SpaceVH(height: 60.0),
              textFild(
                controller: userName,
                image: 'user.svg',
                hintTxt: AppString.fullNameString,
              ),
              textFild(
                controller: userPass,
                image: 'hide.svg',
                isObs: true,
                hintTxt: AppString.passwordString,
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
                    Mainbutton(
                      onTap: () {},
                      text: AppString.singInString,
                      btnColor: blueButton,
                    ),
                    const SpaceVH(height: 20.0),
                    Mainbutton(
                      onTap: () {},
                      text: AppString.loginWithGoogleString,
                      image: 'google.png',
                      btnColor: white,
                      txtColor: blackBG,
                    ),
                    const SpaceVH(height: 20.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SignUpPage()));
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppString.dontHaveAnAccount,
                            style: headline.copyWith(
                              fontSize: 14.0,
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
        ),
      ),
    );
  }
}
