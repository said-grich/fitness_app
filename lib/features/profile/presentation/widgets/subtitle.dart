  import 'package:fitness_app/core/test_style.dart';
import 'package:flutter/material.dart';

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
              style: headline3.copyWith(color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }