

import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String msg;
  const ErrorMessage({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Container( margin: const EdgeInsets.symmetric(horizontal: 20.0,),
          child: Text(msg,style: headline3.copyWith(fontSize: 12,color: redText,),textAlign: TextAlign.right,)));
  }
}
