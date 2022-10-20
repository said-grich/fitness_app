import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/bloc_export.dart';
import 'package:fitness_app/features/products/model/product.dart';
import 'package:flutter/services.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsState.initial());
  void loadCategory() async {
    emit(state.copyWith(status: ProductsStatus.submiting));
    final String dataString =
        await rootBundle.loadString('assets/data/products_list.json');
    final data = await json.decode(dataString);
    List tmp1 = data["BARS"];
    List tmp2 = data["PROTEIN"];
    List tmp3 = data["TOOLS"];
    final List<Product> listOfproductProtien = [];
    final List<Product> listOfproductBars = [];
    final List<Product> listOfproductTools = [];

    for (var element in tmp1) {
      listOfproductBars.add(Product.fromJson(element));
    }
    for (var element in tmp2) {
      listOfproductProtien.add(Product.fromJson(element));
    }
    for (var element in tmp3) {
      listOfproductTools.add(Product.fromJson(element));
    }

    emit(state.copyWith(
        productListBARS: listOfproductBars,
        productListPROTEIN: listOfproductProtien,
        productListTools: listOfproductTools,
        status: ProductsStatus.succes));
  }
}
