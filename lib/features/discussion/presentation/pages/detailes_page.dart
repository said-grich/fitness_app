import 'package:avatar_view/avatar_view.dart';
import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/features/discussion/model/discussion_model.dart';
import 'package:fitness_app/features/discussion/presentation/cubit/discussion_detaills_cubit.dart';
import 'package:fitness_app/features/profile/presentation/widgets/text_fiald_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../profile/presentation/widgets/subtitle.dart';
import '../../../stepper_form/widgets/custom_button.dart';
import '../widgets/describtion_field.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.model});
  final DiscussionModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DiscussionDetaillsCubit()..loadPostUser(model.userId, model.title),
      child: BlocListener<DiscussionDetaillsCubit, DiscussionDetaillsState>(
        listener: (context, state) {
          if (state.status == DiscussionDetaillesStatus.submiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        child: BlocBuilder<DiscussionDetaillsCubit, DiscussionDetaillsState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle.light
                      .copyWith(statusBarColor: blueButton),
                  backgroundColor: blueButton,
                  title: Text(
                      state.profileModel.fullname ?? AppString.errorString),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      DiscussionForm(model: model),
                     
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  custmorOrTrainer(String value) {
    if (value == "trainer") {
      return AppString.trainerString;
    } else {
      return AppString.clintString;
    }
  }
}

class DiscussionForm extends StatelessWidget {
  final DiscussionModel model;

  TextEditingController commentControlller = TextEditingController();

  DiscussionForm({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DiscussionDetaillsCubit()..loadPostUser(model.userId, model.title),
      child: BlocBuilder<DiscussionDetaillsCubit, DiscussionDetaillsState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: blueButton,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
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
                      CustomButton(
                          btnColor: blackBG,
                          onTap: () {},
                          text: custmorOrTrainer(
                              state.profileModel.role ?? AppString.errorString),
                          txtColor: whiteText),
                      const SpaceVH(
                        height: 20,
                      )
                    ],
                  )),
              Text(
                model.title,
                style: headline.copyWith(color: Colors.black),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: model.photourl.isNotEmpty
                      ? Image.network(
                          model.photourl,
                          height: 250,
                        )
                      : Image.asset(
                          "assets/image/default.gif",
                          height: 150,
                        ),
                ),
              ),
              ctextFild(
                initialValue: model.desc,
                image: '',
                subtitle: "",
              ),
              const SpaceVH(height: 30),
              subTitle("${AppString.addComment} :"),
              const SpaceVH(height: 10),
              textFormFild(
                  hintTxt: AppString.commentString,
                  image: '',
                  onChange: (value) {
                    context.read<DiscussionDetaillsCubit>().validComment(value);
                  },
                  controller: commentControlller),
              GestureDetector(
                onTap: () async {
                  await context
                      .read<DiscussionDetaillsCubit>()
                      .addCommnet(model.title);
                },
                child: Container(
                  width: 150,
                  height: 50.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: blackBG,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.addComment,
                        style: headline2.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
               state.comments.isNotEmpty
                          ? BlocBuilder<DiscussionDetaillsCubit, DiscussionDetaillsState>(
                              builder: (context, state) {
                                return Column(
                                  children: state.comments
                                      .map((e) =>  CommentCard(
                                            comment: e.comment,
                                            imagPath: e.photoUrl,
                                            name: e.usernname,
                                          ))
                                      .toList(),
                                );
                              },
                            )
                          : const SpaceVH(
                              height: 0,
                            ),
              const SpaceVH(height: 20),
            ],
          );
        },
      ),
    );
  }

  maleOrFemale(String value) {
    if (value == "Male") {
      return AppString.maleString;
    } else {
      return AppString.femaleString;
    }
  }

  custmorOrTrainer(String value) {
    if (value == "trainer") {
      return AppString.trainerString;
    } else {
      return AppString.clintString;
    }
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
    required this.imagPath,
    required this.name,
    required this.comment,
  }) : super(key: key);
  final String imagPath;
  final String name;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child:  Directionality(
                textDirection: TextDirection.rtl,
        child: Card(
          // ignore: sort_child_properties_last
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Container(
              height: 100,
              color: Colors.white,
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Expanded(
                        child: 
                        AvatarView(
                          radius: 40,
                          borderWidth: 3,
                          borderColor: whiteText,
                          avatarType: AvatarType.CIRCLE,
                          backgroundColor: Colors.transparent,
                          imagePath:imagPath??
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      
                      alignment: Alignment.topLeft,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                           Expanded(
                            flex: 5,
                            child: ListTile(
                              
                              title: Text(name ,style:  headline2.copyWith(fontWeight: FontWeight.bold),),
                              subtitle: Text(comment,style: headline3,)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          elevation: 8,
          margin: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
