import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/widgets/main_button.dart';
import 'package:fitness_app/core/widgets/text_fild.dart';
import 'package:fitness_app/features/discussion/presentation/cubit/discussion_cubit.dart';
import 'package:fitness_app/features/discussion/presentation/pages/detailes_page.dart';
import 'package:fitness_app/features/discussion/presentation/widgets/describtion_field.dart';
import 'package:fitness_app/features/home_page/presentation/pages/home_page.dart';
import 'package:fitness_app/features/profile/presentation/widgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/app_string.dart';
import '../../../../core/colors.dart';
import '../../../../core/test_style.dart';
import '../../../stepper_form/widgets/error_widget.dart';
import '../../model/discussion_model.dart';
import '../widgets/color_filter.dart';

class DiscussionPage extends StatelessWidget {
  const DiscussionPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscussionCubit()..loadDissuction(),
      child: BlocBuilder<DiscussionCubit, DiscussionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: blueButton),
              title: Text(
                AppString.disscutionString,
                style: headline.copyWith(fontSize: 20, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: blueButton,
            ),
            body: ListView.builder(
                itemCount: state.disscutionList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildImageCard(state.disscutionList[index],state.disscutionList[index].title,state.disscutionList[index].photourl,context);
                }),
            floatingActionButton: FloatingActionButton(
              elevation: 50,
              hoverColor: Colors.red,
              autofocus: true,
              onPressed: () {
                

Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AddDiscustion()),
            (Route<dynamic> route) => false,
          );
              },
              tooltip: AppString.adddisscutionString,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget buildImageCard(DiscussionModel discussionModel, String title, String imagePath ,context) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(imagePath),
              colorFilter: ColorFilters.greyscale,
              // ignore: sort_child_properties_last
              child: InkWell(
                onTap: () {
                     Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(model: discussionModel)),
          );
                },
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      );
}

class AddDiscustion extends StatelessWidget {
  const AddDiscustion({super.key});
  static Page page() => const MaterialPage<void>(child: AddDiscustion());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: blueButton),
              title: Text(
                AppString.adddisscutionString,
                style: headline.copyWith(fontSize: 20, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: blueButton,
            ),

      body: SingleChildScrollView(
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[FormDisscution()],
                          ),
                        ),
                      ),

    );
  }
}

class FormDisscution extends StatelessWidget {
  FormDisscution({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscussionCubit(),
      child: Container(
        decoration: const BoxDecoration(color: grayback),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            BlocBuilder<DiscussionCubit, DiscussionState>(
                builder: ((context, state) {
              return state.status == DiscussionStatus.error
                  ? ErrorMessage(msg: state.photoError)
                  : const SpaceVH(height: 0.0);
            })),
            Center(
              child: BlocBuilder<DiscussionCubit, DiscussionState>(
                builder: (context, state) {
                  return Column(children: [
                    textFild(
                        hintTxt: AppString.titleString,
                        image: '',
                        controller: titleController,
                        onChange: (String value) {
                          context.read<DiscussionCubit>().titleChanged(value);
                        }),
                    textFormFild(
                        hintTxt: AppString.descriptionString,
                        image: '',
                        controller: titleController,
                        onChange: (String value) {
                          context.read<DiscussionCubit>().descChanged(value);
                        }),
                    const SpaceVH(
                      height: 20,
                    ),
                    subTitle("${AppString.addPhotoString} :"),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state.photourl.isNotEmpty
                            ? Image.network(
                                state.photourl,
                                height: 250,
                              )
                            : Image.asset(
                                "assets/image/default.gif",
                                height: 150,
                              ),
                      ),
                    ),
                    const SpaceVH(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await context.read<DiscussionCubit>().uploadImage();
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
                              AppString.addPhotoString,
                              style: headline2.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SpaceVH(
                      height: 20,
                    ),
                    Mainbutton(
                        onTap: () {
                          context.read<DiscussionCubit>().submit();

                          
                          if (state.status == DiscussionStatus.succes) {
                            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage(pgaenumber: 2)),
            (Route<dynamic> route) => false,
          );
                          }
                        },
                        text: AppString.submiteString,
                        txtColor: Colors.white,
                        btnColor: blueButton),
                    const SpaceVH(
                      height: 20,
                    ),
                  ]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
