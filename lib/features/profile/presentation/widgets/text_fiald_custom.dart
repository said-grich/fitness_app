import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget ctextFild(
    {
    required String image,
    required String initialValue,
    required String subtitle,
  }) {
  return Directionality(
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
            child: Text(subtitle + " " +initialValue,
              style: headline2.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          
        ],
      ),
    ),
  );
}
