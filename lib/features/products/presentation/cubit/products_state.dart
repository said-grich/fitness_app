// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_cubit.dart';

enum ProductsStatus { initial, submiting, succes, error }

class ProductsState extends Equatable {
  const ProductsState({required this.checkoutList, required this.status, required this.productListBARS ,required this.productListPROTEIN, required  this.productListTools });
  final ProductsStatus status;
  final List<Product> productListBARS;
  final List<Product> productListPROTEIN;
  final List<Product> productListTools;
  final List<Product> checkoutList;


  factory ProductsState.initial() {
    return const ProductsState(status: ProductsStatus.initial, productListBARS: [],productListPROTEIN: [] , productListTools:  [], checkoutList: []);
  }

  @override
  List<Object> get props => [status, productListBARS,productListPROTEIN,productListTools,checkoutList];





  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? productListBARS,
    List<Product>? productListPROTEIN,
    List<Product>? productListTools,
    List<Product>? checkoutList,
  }) {
    return ProductsState(
      status: status ?? this.status,
      productListBARS: productListBARS ?? this.productListBARS,
      productListPROTEIN: productListPROTEIN ?? this.productListPROTEIN,
      productListTools: productListTools ?? this.productListTools,
      checkoutList: checkoutList ?? this.checkoutList,
    );
  }
}
