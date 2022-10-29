import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget dropDown({
  required  List<String> items,
  
  required String vlaue,
  required Function(dynamic value)? onChange
}) {
  return  Directionality(
    textDirection: TextDirection.rtl,

    child: Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: blackTextFild,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: 170.0,
            child:  DropdownButton(
               value: vlaue,
              // Initial Value               
              // Down Arrow Icon
                     icon: const Icon(Icons.restaurant_menu),

              // Array list of items
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item ,
                  child: Text(item ,style: headline3.copyWith(fontSize: 14 ,color: Colors.black,)),
                );
              }).toList(),

              // After selecting the desired option,it will
              // change button value to selected value
              onChanged:onChange
              )
              
            ),
         
        ],
      ),
    ),
  );
}