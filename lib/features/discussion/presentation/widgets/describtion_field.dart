import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:flutter/material.dart';



Widget textFormFild({
  required String hintTxt,
  required String image,
  required TextEditingController controller,
  
  bool isObs = false,
  TextInputType? keyBordType,
  required Function(String value) onChange
}) {
  return  Directionality(
                textDirection: TextDirection.rtl,

    child: Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
            width: 240.0,
            child: TextFormField(
              
              onChanged: onChange,
              textAlignVertical: TextAlignVertical.center,
              textDirection: TextDirection.rtl,
              obscureText: isObs,
              keyboardType: keyBordType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintTxt,
                hintStyle: hintStyle,
              ),
              style: headline2,
            ),
          ),
          
        ],
      ),
    ),
  );
}
