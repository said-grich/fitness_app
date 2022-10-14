import 'package:avatar_view/avatar_view.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/core/widgets/main_button.dart';
import 'package:fitness_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fitness_app/features/profile/presentation/widgets/text_fiald_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../stepper_form/widgets/custom_button.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfileFromFirabse(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: state.status == ProfileStatus.submiting,
            child: Scaffold(
                appBar: AppBar(
                  
                  systemOverlayStyle: SystemUiOverlayStyle.light
                      .copyWith(statusBarColor: blueButton),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  
                  toolbarHeight: 270, // Set this height
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        color: blueButton,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 50, bottom: 10),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                     BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return IconButton(
                
                key: const Key('homePage_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                alignment: Alignment.centerRight,
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AppUserLogoutRequested());
                },
              );
            },
          ),
          const SpaceVH(width: 60,)            ,                        Text(
                                      AppString.profileString,
                                      style: headline.copyWith(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                )),
                            const SpaceVH(
                              height: 10,
                            ),
                            AvatarView(
                              radius: 60,
                              borderWidth: 8,
                              borderColor: whiteText,
                              avatarType: AvatarType.CIRCLE,
                              backgroundColor: Colors.transparent,
                              imagePath: state.profileModel.photoUrl ??
                                  "assets/image/profile.png",
                              placeHolder: const Icon(
                                Icons.person,
                                size: 50,
                              ),
                              errorWidget: const Icon(
                                Icons.error,
                                size: 50,
                              ),
                            ),
                              const SpaceVH(
                              height: 10,
                            ),
                            CustomButton(btnColor: blackBG, onTap: () {  }, text: custmorOrTrainer(state.profileModel.role?? AppString.errorString),txtColor:whiteText),

                          ],
                        );
                      },
                    ),
                  ),
                ),
                body: const ProfileForme()),
          );
        },
      ),
    );
  }
      custmorOrTrainer(String value) {
    if (value=="trainer") {
      return AppString.trainerString;
    }else{
       return AppString.clintString;
    }
  }
}

class ProfileForme extends StatelessWidget {
  const ProfileForme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                ctextFild(
                    image: '',
                    initialValue:
                        state.profileModel.fullname ?? AppString.errorString, subtitle:AppString.fullNameString+" :"),
                ctextFild(
                  initialValue: state.profileModel.sex != null
                      ? maleOrFemale(state.profileModel.sex!)
                      : AppString.errorString,
                  image: '', subtitle: AppString.sexString,
                ),ctextFild(
                  initialValue: state.profileModel.age ?? AppString.errorString,
                  image: '', subtitle: AppString.ageString,
                ),
               ctextFild(
                  initialValue: state.profileModel.poids ?? AppString.errorString,
                  image: '', subtitle: AppString.poidString,
                ), ctextFild(
                  initialValue: state.profileModel.length ?? AppString.errorString,
                  image: '', subtitle: AppString.lenghtStirng,
                ),
                ctextFild(
                  initialValue: state.profileModel.email ?? AppString.errorString,
                  image: '', subtitle:AppString.emailString+" :",
                ),
                ctextFild(
                  initialValue: state.profileModel.phone ?? AppString.errorString,
                  image: '', subtitle: AppString.phoneNumberString +" :",
                ),
               
              ],
            ),
          )
        ]);
      },
    );
  }

  maleOrFemale(String value) {
    if (value=="Male") {
      return AppString.maleString;
    }else{
       return AppString.femaleString;
    }
  }



}
