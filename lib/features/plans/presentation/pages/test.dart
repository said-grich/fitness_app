// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';

// import '../widgets/rainting_bar.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final double _borderRadius = 24;

//   var items = [
//     PlaceInfo('Dubai Mall Food Court', const Color(0xff6DC8F3), const Color(0xff73A1F9),
//         4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
//     PlaceInfo('Hamriyah Food Court', const Color(0xffFFB157), const Color(0xffFFA057), 3.7,
//         'Sharjah', 'All you can eat · Casual · Groups'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Foody'),
//       ),
//       body: cardList(items: items, borderRadius: _borderRadius),
//     );
//   }
// }

// class CardList extends StatelessWidget {
//   const CardList({
//     Key? key,
//     required this.items,
//     required double borderRadius,
//   }) : _borderRadius = borderRadius, super(key: key);

//   final List<PlaceInfo> items;
//   final double _borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         return Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(_borderRadius),
//                     gradient: LinearGradient(colors: [
//                       items[index].startColor,
//                       items[index].endColor
//                     ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//                     boxShadow: [
//                       BoxShadow(
//                         color: items[index].endColor,
//                         blurRadius: 12,
//                         offset: const Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   bottom: 0,
//                   top: 0,
//                   child: CustomPaint(
//                     size: const Size(100, 150),
//                     painter: CustomCardShapePainter(_borderRadius,
//                         items[index].startColor, items[index].endColor),
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         // ignore: sort_child_properties_last
//                         child: Image.asset(
//                           'assets/icon.png',
//                           height: 64,
//                           width: 64,
//                         ),
//                         flex: 2,
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               items[index].name,
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'Avenir',
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             Text(
//                               items[index].category,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Avenir',
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Row(
//                               children: <Widget>[
//                                 const Icon(
//                                   Icons.location_on,
//                                   color: Colors.white,
//                                   size: 16,
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 Flexible(
//                                   child: Text(
//                                     items[index].location,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Avenir',
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Text(
//                               items[index].rating.toString(),
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'Avenir',
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             RatingBar(rating: items[index].rating),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class PlaceInfo {
//   final String name;
//   final String category;
//   final String location;
//   final double rating;
//   final Color startColor;
//   final Color endColor;

//   PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
//       this.location, this.category);
// }

// class CustomCardShapePainter extends CustomPainter {
//   final double radius;
//   final Color startColor;
//   final Color endColor;

//   CustomCardShapePainter(this.radius, this.startColor, this.endColor);

//   @override
//   void paint(Canvas canvas, Size size) {
//     var radius = 24.0;

//     var paint = Paint();
//     paint.shader = ui.Gradient.linear(
//         const Offset(0, 0), Offset(size.width, size.height), [
//       HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
//       endColor
//     ]);

//     var path = Path()
//       ..moveTo(0, size.height)
//       ..lineTo(size.width - radius, size.height)
//       ..quadraticBezierTo(
//           size.width, size.height, size.width, size.height - radius)
//       ..lineTo(size.width, radius)
//       ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
//       ..lineTo(size.width - 1.5 * radius, 0)
//       ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }