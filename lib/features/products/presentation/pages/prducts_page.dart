import 'dart:math';

import 'package:fitness_app/core/app_string.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/space.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/features/products/model/product.dart';
import 'package:fitness_app/features/products/presentation/cubit/products_cubit.dart';
import 'package:fitness_app/features/products/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductsListPage extends StatelessWidget {
  ProductsListPage({super.key, required this.produitList, required this.title});

  final List<Product> produitList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle.light.copyWith(statusBarColor: blueButton),
          title: Text(
            title,
            style: headline.copyWith(fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: blueButton,
          actions: [
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return IconButton(
                  key: const Key('homePage_logout_iconButton'),
                  icon: const Icon(Icons.shopping_cart_checkout,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CheckOut( produitList: state.checkoutList )));
                  },
                );
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            const SizedBox(height: 15.0),
            Container(
                padding: const EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width - 30.0,
                height: MediaQuery.of(context).size.height - 50.0,
                child: GridView.count(
                  crossAxisCount: 2,
                  primary: false,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.8,
                  children: produitList
                      .map((e) => _buildCard(e.name ?? "", e.price ?? "",
                          e.photoUrl ?? "", false, false, context, e))
                      .toList(),
                )),
            const SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(String name, String price, String imgPath, bool added,
    bool isFavorite, context, Product product) {
  var chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => CookieDetail(
            //       assetPath: imgPath,
            //       cookieprice:price,
            //       cookiename: name
            //     )));
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                        tag: rnd,
                        child: Container(
                            height: 75.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imgPath),
                                    fit: BoxFit.contain)))),
                  ),
                  const SizedBox(height: 7.0),
                  Text(price,
                      style: headline2.copyWith(
                          color: blueButton, fontWeight: FontWeight.bold)),
                  Text(name, style: headline3.copyWith(fontSize: 12)),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: const Color(0xFFEBEBEB), height: 1.0)),
                  BlocProvider(
                    create: (context) => ProductsCubit(),
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<ProductsCubit>()
                                .addTocheckOut(product);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!added) ...[
                                  const Icon(Icons.add,
                                      color: blueButton, size: 14.0),
                                  const SpaceVH(
                                    width: 2,
                                  ),
                                  Text(AppString.addtoCheckoutString,
                                      style: headline3.copyWith(fontSize: 11))
                                ],
                              ]),
                        );
                      },
                    ),
                  )
                ])),
          )));
}
