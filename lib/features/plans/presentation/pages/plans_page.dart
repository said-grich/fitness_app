import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/test_style.dart';
import '../widgets/list_card.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});
  

  @override
  Widget build(BuildContext context) {
      var items = [
    PlaceInfo('خططي الغدائية', const Color(0xff6DC8F3), const Color(0xff73A1F9),
        4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids','diet.png'),
    PlaceInfo('خططي الرياضية', const Color(0xffFFB157), const Color(0xffFFA057), 3.7,
        'Sharjah', 'All you can eat · Casual · Groups','fitness.png'),
  ];

    return Scaffold(

        appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light
                      .copyWith(statusBarColor: blueButton),

              title: Text(AppString.plansString, style:  headline.copyWith(
                                          fontSize: 20, color: Colors.white),),
              centerTitle: true,
              backgroundColor: blueButton,

        ),body: CardList(items: items, borderRadius: 24,)
        
        
        
        
        ,


    );
  }
}
