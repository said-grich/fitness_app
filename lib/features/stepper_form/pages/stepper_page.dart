// ignore_for_file: constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'package:avatar_view/avatar_view.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:fitness_app/features/authentication/repository/authentication_repository.dart';
import 'package:fitness_app/features/home_page/presentation/pages/home_page.dart';
import 'package:fitness_app/features/stepper_form/cubit/stepper_cubit.dart';
import 'package:fitness_app/features/stepper_form/widgets/custom_button.dart';
import 'package:fitness_app/features/stepper_form/widgets/error_widget.dart';
import 'package:fitness_app/features/stepper_form/widgets/textFild_min_width.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../core/colors.dart';
import '../../../core/style.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});
  static Page page() => const MaterialPage<void>(child: StepperPage());

  @override
  // ignore: library_private_types_in_public_api
  _StepperDemoState createState() => _StepperDemoState();
}

enum Gender { Male, Female, Others }

class _StepperDemoState extends State<StepperPage> {
  StepperType stepperType = StepperType.vertical;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController poidController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            StepperCubit(context.read<AuthenticationRepository>()),
        child: Scaffold(
          backgroundColor: grayback,
          body: BlocConsumer<StepperCubit, StepperState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Builder(builder: (context) {
                return LoadingOverlay(
                  isLoading: state.status == StepperStatus.submitting,
                  child: Column(
                    children: [
                      Expanded(
                          child: Theme(
                        data: Stlyes.stripeThemeData(),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Stepper(
                            controlsBuilder: (context, details) {
                              return Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CustomButton(
                                      onTap: () {
                                        context
                                            .read<StepperCubit>()
                                            .continued();
                                      },
                                      text: AppString.nextString,
                                      btnColor: blueButton,
                                    ),
                                    CustomButton(
                                      onTap: () {
                                        context.read<StepperCubit>().cancel();
                                      },
                                      text: AppString.cancelString,
                                      btnColor: grayText,
                                    )
                                  ],
                                ),
                              );
                            },
                            elevation: 0,
                            type: StepperType.vertical,
                            physics: const ScrollPhysics(),
                            currentStep: state.currentStep,
                            onStepTapped: (step) {
                              context.read<StepperCubit>().tapped(step);
                            },
                            steps: <Step>[
                              Step(
                                title: Text(AppString.personalInfo),
                                content: Column(
                                  children: <Widget>[
                                    const SpaceVH(height: 50.0),
                                    textFieldWith(
                                      controller: fullNameController,
                                      image: 'user.svg',
                                      keyBordType: TextInputType.name,
                                      hintTxt: AppString.fullNameString,
                                      onChange: (String value) {
                                        context
                                            .read<StepperCubit>()
                                            .nameValidation(value);
                                      },
                                    ),
                                    const SpaceVH(height: 2.0),
                                    state.status == StepperStatus.error
                                        ? ErrorMessage(msg: state.errorMsgPhone)
                                        : const SpaceVH(height: 0.0),
                                    const SpaceVH(height: 5.0),
                                    subTitle(AppString.sexString),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          addGenderRadioButton(
                                              0, AppString.maleString),
                                          addGenderRadioButton(
                                              1, AppString.femaleString),
                                        ],
                                      ),
                                    ),
                                    subTitle(AppString.roleString),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          addTypeRadioButton(
                                              0, AppString.trainerString),
                                          addTypeRadioButton(
                                              1, AppString.clintString),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                isActive: state.currentStep >= 0,
                                state: state.currentStep >= 0
                                    ? StepState.complete
                                    : StepState.disabled,
                              ),
                              Step(
                                title: Text(AppString.bodyInfString,
                                    style: state.currentStep >= 1
                                        ? const TextStyle()
                                        : headline3.copyWith(color: Colors.black)),
                                content: Column(
                                  children: <Widget>[
                                    const SpaceVH(height: 10.0),
                                    textFieldWith(
                                      controller: ageController,
                                      image: 'user.svg',
                                      keyBordType: TextInputType.number,
                                      hintTxt: AppString.ageString,
                                      onChange: (String value) {
                                        context
                                            .read<StepperCubit>()
                                            .ageValidation(value);
                                      },
                                    ),
                                    const SpaceVH(height: 2.0),
                                    state.status == StepperStatus.error &&
                                            state.errorMsgAge.isNotEmpty
                                        ? ErrorMessage(msg: state.errorMsgAge)
                                        : const SpaceVH(height: 0.0),
                                    textFieldWith(
                                      controller: lengthController,
                                      image: 'user.svg',
                                      keyBordType: TextInputType.number,
                                      hintTxt: AppString.lenghtStirng,
                                      onChange: (String value) {
                                        context
                                            .read<StepperCubit>()
                                            .lenghtValidation(value);
                                      },
                                    ),
                                    state.status == StepperStatus.error &&
                                            state.errorMsgPoids.isNotEmpty
                                        ? ErrorMessage(msg: state.errorMsgPoids)
                                        : const SpaceVH(height: 0.0),
                                    textFieldWith(
                                      controller: poidController,
                                      image: 'user.svg',
                                      keyBordType: TextInputType.number,
                                      hintTxt: AppString.poidString,
                                      onChange: (String value) {
                                        context
                                            .read<StepperCubit>()
                                            .poidValidation(value);
                                      },
                                    ),
                                  ],
                                ),
                                isActive: state.currentStep >= 0,
                                state: state.currentStep >= 1
                                    ? StepState.complete
                                    : StepState.disabled,
                              ),
                              Step(
                                title: Text(AppString.moreInfoString,
                                    style: state.currentStep == 2
                                        ? const TextStyle()
                                        : headline3.copyWith(color: Colors.black)),
                                content: Column(
                                  children: <Widget>[
                                    textFieldWith(
                                      controller: phoneController,
                                      image: 'user.svg',
                                      keyBordType: TextInputType.number,
                                      hintTxt: AppString.phoneNumberString,
                                      onChange: (String value) {
                                        context
                                            .read<StepperCubit>()
                                            .phoneNumberValidation(value);
                                      },
                                    ),
                                    const SpaceVH(height: 2.0),
                                    state.status == StepperStatus.error
                                        ? ErrorMessage(msg: state.errorMsgPhone)
                                        : const SpaceVH(height: 0.0),
                                    const SpaceVH(height: 20.0),
                                    AvatarView(
                                      radius: 60,
                                      borderWidth: 8,
                                      borderColor: whiteText,
                                      avatarType: AvatarType.CIRCLE,
                                      backgroundColor: Colors.transparent,
                                      imagePath: state.photoUrl.isNotEmpty
                                          ? state.photoUrl
                                          : "assets/image/profile.png",
                                      placeHolder: Container(
                                        child: Icon(
                                          Icons.person,
                                          size: 50,
                                        ),
                                      ),
                                      errorWidget: Container(
                                        child: Icon(
                                          Icons.error,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                    const SpaceVH(height: 20.0),
                                    GestureDetector(
                                      onTap: () async {
                                        await context
                                            .read<StepperCubit>()
                                            .uploadImage();
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 50.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color: blueButton,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              AppString.addPhotoString,
                                              style: headline2,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                isActive: state.currentStep >= 0,
                                state: state.currentStep >= 2
                                    ? StepState.complete
                                    : StepState.disabled,
                              ),
                            ],
                          ),
                        ),
                      )),
                      state.currentStep == 2
                          ? const SpaceVH(height: 10.0)
                          : const SpaceVH(height: 0.0),
                      state.currentStep == 2
                          ? GestureDetector(
                              onTap: () async {
                                await context
                                    .read<StepperCubit>()
                                    .saveUserTodb(select, selectType);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            const HomePage()));

                                context.read<AuthenticationBloc>().add(AppUserInfoComplete());
                              },
                              child: Container(
                                height: 50.0,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                  color: blueButton,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      AppString.singUpString,
                                      style: headline2,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SpaceVH(height: 0.0),
                      state.currentStep == 2
                          ? const SpaceVH(height: 10.0)
                          : const SpaceVH(height: 0),
                    ],
                  ),
                );
              });
            },
          ),
        ));
  }

  Directionality subTitle(String title) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: headline3,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  List gender = ["Male", "Female"];

  late String select = '';

  Row addGenderRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Theme(
          data:
              Stlyes.themeData().copyWith(unselectedWidgetColor: blueButton),
          child: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: gender[btnValue],
            groupValue: select,
            onChanged: (value) {
              setState(() {
                select = value;
              });
            },
          ),
        ),
        Text(
          title,
          style: headline2,
        )
      ],
    );
  }

  List types = ["trainer", "customer"];

  late String selectType = '';

  Row addTypeRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Theme(
          data:
              Stlyes.themeData().copyWith(unselectedWidgetColor: blueButton),
          child: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: types[btnValue],
            groupValue: selectType,
            onChanged: (value) {
              setState(() {
                selectType = value;
              });
            },
          ),
        ),
        Text(
          title,
          style: headline2,
        )
      ],
    );
  }
}
