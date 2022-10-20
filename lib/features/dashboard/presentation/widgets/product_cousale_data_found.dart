import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitness_app/features/products/presentation/pages/product_category.dart';
import 'package:flutter/material.dart';
import '../../../../core/test_style.dart';
import '../../../products/model/product.dart';

class ProductCarouselSliderDataFound extends StatefulWidget {
  final List<Product> carouselList = [
    Product.fromJson({
      "name": "بروتين مصل اللبن",
      "desc":
          "بروتين مصل اللبن هو أحد البروتينات الأساسية الموجودة في منتجات الألبان. نتيجة ثانوية لعملية صنع الجبن ، يوفر بروتين مصل اللبن كميات كبيرة من الأحماض الأمينية الأساسية اللازمة لأداء الوظائف التي تؤديها البروتينات في الجسم.",
      "price": "11.64",
      "photoUrl":
          "https://media.24protein.com/media/catalog/product/cache/b086b137f52447e15b5d98a5006d223f/l/i/live3_260x_2x_1.jpg"
    }),
    Product.fromJson({
      "name": "بروتين الشرش المعزول",
      "desc":
          "الواي إيزوليت من شركة Scitec Nutrition، هي من بين أهم مكملات الواي بروتين في السوق، تمتاز بخصائصها الغذائية العالية، مصممة خصيصا للرياضيين الذين يبحثون عن بناء عضلي فعال.",
      "price": "12",
      "photoUrl":
          "https://media.24protein.com/media/catalog/product/cache/b086b137f52447e15b5d98a5006d223f/2/d/2da54a74.jpg"
    }),
    Product.fromJson({
      "name": "جامبو بار (15 × 100 جرام)",
      "desc":
          "تعتبر ألواح جامبو الجديدة من سايتك مثالية كوجبة خفيفة أو بعد التدريب لاكتساب أقصى كتلة عضلية. + قرائة المزيد",
      "price": "35",
      "photoUrl":
          "https://www.nutrilionz.ma/media/catalog/product/cache/2/thumbnail/600x681/9df78eab33525d08d6e5fb8d27136e95/j/u/jumbo-bar-x15-scitec-nutrition_1.jpg"
    })
  ];
  ProductCarouselSliderDataFound({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductCarouselSliderDataFoundState createState() =>
      _ProductCarouselSliderDataFoundState();
}

class _ProductCarouselSliderDataFoundState
    extends State<ProductCarouselSliderDataFound> {
  int _current = 0;
  late List<Widget> imageSlider;

  @override
  void initState() {
    imageSlider = widget.carouselList
        .map((e) => customBuildCard(e.name ?? "", e.photoUrl ?? "", context))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: imageSlider,

            options: CarouselOptions(
              autoPlay: true,
              pageSnapping: true,
              viewportFraction: 0.5,
              disableCenter: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
       
      ],
    );
  }
}

Widget customBuildCard(String name, String imgPath, context) {
  return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>Category()));
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8 ,bottom: 8, left: 8 ,right: 8),
                    child: Hero(
                        tag: imgPath,
                        child: Container(
                            height: 75.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imgPath),
                                    fit: BoxFit.contain)))),
                  ),
                  const SizedBox(height: 7.0),
                  Text(name, style: headline3.copyWith(fontSize: 12)),
                  
                ])),
          )));
}
