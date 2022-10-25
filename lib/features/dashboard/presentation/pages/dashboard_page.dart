import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:fitness_app/features/dashboard/presentation/widgets/product_cousale_data_found.dart';
import 'package:fitness_app/features/plans/presentation/pages/plans_page.dart';
import 'package:fitness_app/features/profile/presentation/widgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/bloc_export.dart';
import '../../../../core/colors.dart';
import '../../../../core/test_style.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../home_page/presentation/widgets/carsoul_data_not_found.dart';
import '../../../home_page/presentation/widgets/cousale_data_found.dart';
import '../../../profile/model/profile_model.dart';
import '../widgets/nav_darawer.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required
   this.model});
    final ProfileModel model;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
    
    
        drawer: const NavDrawer(),
        appBar: AppBar(
    
           leading: Builder(
              builder: (context) => IconButton(
                  icon: const Icon(Icons.menu , color: Colors.black),
                  onPressed: () {
                  Scaffold.of(context).openDrawer();
                  },
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppString.appTitle,
            style: headline.copyWith(
                fontStyle: FontStyle.italic, color: Colors.black, fontSize: 40),
          ),
          actions: <Widget>[
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return IconButton(
                  key: const Key('homePage_logout_iconButton'),
                  icon: const Icon(Icons.exit_to_app, color: Colors.black),
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AppUserLogoutRequested());
                  },
                );
              },
            )
          ],
          systemOverlayStyle:
              SystemUiOverlayStyle.dark.copyWith(statusBarColor: grayback),
        ),
        body: BlocProvider(
          create: (context) => DashboardCubit()..loadCorousel(),
          child: SafeArea(child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
               if(state.status==DashboardStatus.submiting)
                  // ignore: curly_braces_in_flow_control_structures
                  if(state.discussionList.isNotEmpty) {
                    return Column(
                      children: [
                        CarouselSliderDataFound(state.discussionList),
                                               const SpaceVH(height: 10,),

                        title("${AppString.productsIntrString} :"),
                        const SpaceVH(height: 5,),
                        ProductCarouselSliderDataFound(),
                        const SpaceVH(height: 25,),
                        GestureDetector(
                          onTap: (){
                             Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  PlansPage(model: model,)));
                          },
                          child: Card(
                            
                              shape: RoundedRectangleBorder(
                                
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: blueButton,
                              elevation: 10,
                              child: SizedBox(
                                height: 60,
                                child:  Center(
                                  
                                  child:  Text(AppString.plansString,style: headline2.copyWith(color: Colors.white ,fontSize: 22 ,fontWeight: FontWeight.bold),)),
                              ),
                              
                              
                              ),
                        )


                      ],
                    );
                  } else {
                    return Column(
                      children: [
                         const CarouselLoading(),
                         title("${AppString.productsIntrString} :"),
                        ProductCarouselSliderDataFound(),
                      ],
                    );
                  }
                else
                  if(state.discussionList.isNotEmpty) {
                    return Column(
                      children: [
                        CarouselSliderDataFound(state.discussionList),
                         title("${AppString.productsIntrString} :"),
                        ProductCarouselSliderDataFound(),
                        
                      ],
                    );
                  } else {
                    return Container();
                  }




              },
          )),
        ),
      ),
    );
  }
}



Directionality title(String title) {
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
              style: headline3.copyWith(color: Colors.black ,fontSize: 18),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }