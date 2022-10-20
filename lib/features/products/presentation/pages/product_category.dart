import 'dart:convert';

import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/products/presentation/pages/prducts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/app_string.dart';
import '../../../../core/colors.dart';
import '../../../../core/test_style.dart';
import '../../../plans/presentation/widgets/list_card.dart';
import '../cubit/products_cubit.dart';
import '../widgets/category_widget.dart';

import '../../model/category_model.dart';

class Category extends StatelessWidget {
  Category({super.key});

  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..loadCategory(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle.light.copyWith(statusBarColor: blueButton),
          title: Text(
            AppString.productsString,
            style: headline.copyWith(fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: blueButton,
        ),
        backgroundColor: const Color(0xFFFCFAF8),
        body: ListView(
          children: <Widget>[
            const SizedBox(height: 15.0),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {

                var items = [
    ProductInfo('مكملات غدائية', const Color(0xff6DC8F3),
        const Color(0xff73A1F9), 4.4, '', '', 'protien_poider.png', state.productListPROTEIN),
    ProductInfo('مأكولات خفيفة لرياضين', const Color(0xffFFB157),
        const Color(0xffFFA057), 3.7, '', '', 'protien_bar.png', state.productListBARS),
    ProductInfo('معدات رياضية ', const Color.fromARGB(255, 255, 87, 199),
        const Color.fromARGB(255, 202, 87, 255), 3.7, '', '', 'tools.png', state.productListTools),
  ];
                return SizedBox(
                    width: MediaQuery.of(context).size.width - 30.0,
                    height: MediaQuery.of(context).size.height - 50.0,
                    child: CategoryCardList(
                      items: items,
                      borderRadius: 24,
                    ));
              },
            ),
            const SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }
}
