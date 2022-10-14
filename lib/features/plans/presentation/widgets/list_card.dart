import 'package:fitness_app/core/colors.dart';
import 'package:fitness_app/core/test_style.dart';
import 'package:fitness_app/features/plans/presentation/widgets/rainting_bar.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class CardList extends StatelessWidget {
  const CardList({
    Key? key,
    required this.items,
    required double borderRadius,
  }) : _borderRadius = borderRadius, super(key: key);

  final List<PlaceInfo> items;
  final double _borderRadius;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    gradient: LinearGradient(colors: [
                      items[index].startColor,
                      items[index].endColor
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                        color: items[index].endColor,
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: CustomPaint(
                    size: const Size(100, 150),
                    painter: CustomCardShapePainter(_borderRadius,
                        items[index].startColor, items[index].endColor),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        // ignore: sort_child_properties_last
                        child: Image.asset(
                          'assets/image/${items[index].icon}',
                          height: 100,
                          width: 100
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                           Directionality(
                    textDirection: TextDirection.rtl,
                              child: Text(
                                items[index].name,
                                style: headline.copyWith(color: whiteText ,fontSize: 18),
                              ),
                            ),
                            
                          
                          ],
                        ),
                      ),
                  
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;
  final String icon;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category, this.icon);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}