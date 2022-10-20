// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/products/model/product.dart';

// ignore: must_be_immutable
class CheckOutModel extends Equatable {
  Product product;
  int   amount;
  CheckOutModel({
    required this.product,
    required this.amount,
  });


  
  @override
  List<Object?> get props => [product];

 
}
