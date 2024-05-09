import 'package:controlapp/messages/odometry.dart';
// import 'package:controlapp/models/waypoint.dart';

import 'package:provider/provider.dart';
// import 'package:controlapp/providers/waypointprovider.dart';
import 'package:controlapp/providers/odomprovider.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:vector_math/vector_math.dart' show radians, Quaternion;
import 'dart:math' as math;

class MapPainter extends CustomPainter {
  final double waveRadius;
  final Color waveAccentColor;
  final Color waveColor;
  final Odometry robotOdom;
  final ui.Image map;
  // final WaypointList waypoints;
  // final Waypoint activeWaypoint;

  late Paint wavePaint, wavePaint2, solidPaint, waypointPaint;
  double robotFootprint = 4.0;
  double maxRadius = 15;
  double gaps = 5;
  bool debugGrig;

  double waypointMinSize = 3;
  double waypointRadiusMax = 5;
  int waypointSides = 4;

  MapPainter({
    required this.map,
    required this.waveRadius,
    required this.waveAccentColor,
    required this.waveColor,
    required this.robotOdom,
    // required this.waypoints,
    // required this.activeWaypoint,
    this.debugGrig = false,
  }) {
    wavePaint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..isAntiAlias = true;
    wavePaint2 = Paint()
      ..color = waveAccentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..isAntiAlias = true;
    solidPaint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..isAntiAlias = true;
    waypointPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    {
      canvas.scale(-2, 2);
      // canvas.translate(0, map.height.toDouble());

      canvas.translate(map.width / 2, map.height / 2);
      canvas.rotate(radians(180));

      // canvas.translate(-map.width / 2, -map.height / 2);

      // canvas.scale(1, -1);
      canvas.translate(0, -map.height.toDouble() / 2);

      canvas.save();
      {
        canvas.translate(9, 9);
        canvas.drawImage(map, Offset.zero, Paint());
      }
      canvas.restore();

      canvas.save();
      {
        double centerX = map.width / 2;
        double centerY = map.height / 2;
        canvas.translate(centerX, centerY);

        const resolution = 0.05;

        //Siatka do debugowania pozycji na mapie
        //region
        if (debugGrig) {
          for (var i = -20; i <= 20; i++) {
            canvas.drawLine(
              Offset(i / resolution, -20 / resolution),
              Offset(i / resolution, 20 / resolution),
              Paint()..color = Colors.grey.withOpacity(0.3),
            );
            canvas.drawLine(
              Offset(-10 / resolution, i / resolution),
              Offset(10 / resolution, i / resolution),
              Paint()..color = Colors.grey.withOpacity(0.3),
            );
          }
        }
        //endregion

        //draw waypoints
        // var miliseconds = DateTime.now().millisecondsSinceEpoch;
        // var animationSizePercent = (miliseconds % 1700) / 1700;
        // for (var item in waypoints.waypoints) {
        //   canvas.save();
        //   {
        //     canvas.translate(item.x / resolution, item.y / resolution);
        //     canvas.drawPath(
        //         drawNSide(
        //           6,
        //           waypointMinSize +
        //               (animationSizePercent *
        //                   (waypointRadiusMax - waypointMinSize)),
        //         ),
        //         waypointPaint
        //           ..color = item.color.withOpacity(animationSizePercent));
        //     canvas.restore();
        //   }
        // }
        double robotPositionX = (robotOdom.pose.position.x) / resolution;
        double robotPositionY = (robotOdom.pose.position.y) / resolution;

        //draw robot
        var robotCenter = const Offset(0, 0);
        var currentRadius = waveRadius;
        bool drawOnce = true;
        while (currentRadius < maxRadius) {
          //Drawing waypoints
          // for (var item in waypoints.waypoints) {
          //   bool active = item == activeWaypoint;
          //   canvas.save();
          //   canvas.translate(item.x / resolution, item.y / resolution);
          //   //---Pulsating inner
          //   if (active) {
          //     canvas.drawPath(
          //         drawNSide(waypointSides, currentRadius * 0.8),
          //         waypointPaint
          //           ..style = PaintingStyle.fill
          //           ..strokeWidth = 1
          //           ..color =
          //               item.color.withOpacity(1 - currentRadius / maxRadius));
          //   }
          //   //---Pulsating outer
          //   canvas.drawPath(
          //       drawNSide(waypointSides, currentRadius * 0.8),
          //       waypointPaint
          //         ..style = PaintingStyle.stroke
          //         ..strokeWidth = active ? 1 : 0.2
          //         ..color =
          //             item.color.withOpacity(1 - currentRadius / maxRadius));
          //   //---Solid shape
          //   canvas.drawPath(
          //       drawNSide(waypointSides, 3),
          //       waypointPaint
          //         ..style = PaintingStyle.fill
          //         ..color = item.color.withOpacity(1));
          //   canvas.restore();
          // }

          //Drawing robot
          canvas.save();
          canvas.translate(robotPositionX, robotPositionY);

          //---Drawing Cone shape
          if (drawOnce) {
            canvas.save();
            var robotRotation = Quaternion(
                robotOdom.pose.orientation.x,
                robotOdom.pose.orientation.y,
                robotOdom.pose.orientation.z,
                robotOdom.pose.orientation.w);
            canvas.rotate(robotOdom.pose.orientation.x < 0
                ? robotRotation.radians
                : -robotRotation.radians);

            var rect = Rect.fromCircle(
              center: const Offset(0, 0),
              radius: 15.0,
            );

            var gradient = RadialGradient(
              colors: [
                waveColor.withOpacity(0),
                waveColor.withOpacity(0),
                waveAccentColor.withOpacity(0.7),
                waveAccentColor.withOpacity(0.0),
              ],
              stops: const [0.0, 0.25, 0.251, 1.0],
            );

            //---/---/create the Shader from the gradient and the bounding square
            var paint = Paint()..shader = gradient.createShader(rect);

            canvas.drawPath(drawCone(15, 55), paint..isAntiAlias = true);
            canvas.restore();
            //---/---/preventing blinking
            drawOnce = false;
          }
          canvas.drawCircle(
              robotCenter,
              currentRadius,
              wavePaint
                ..color =
                    wavePaint.color.withOpacity(1 - currentRadius / maxRadius));
          canvas.drawCircle(
              robotCenter,
              currentRadius,
              wavePaint2
                ..color = wavePaint2.color
                    .withOpacity(1 - currentRadius / maxRadius));
          canvas.drawCircle(robotCenter, 3, solidPaint);
          canvas.restore();

          currentRadius += 7;
        }
      }
      canvas.restore();
    }
    canvas.restore();
  }

  Path drawNSide(int sides, double radius) {
    assert(sides >= 3);
    final shape = Path();
    var angle = (math.pi * 2) / sides;
    // Offset firstPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));
    Offset firstPoint = Offset(radius * 1, 0);
    shape.moveTo(firstPoint.dx, firstPoint.dy);
    for (int i = 1; i <= sides; i++) {
      double shapeX = radius * math.cos(angle * i);
      double shapeY = radius * math.sin(angle * i);
      shape.lineTo(shapeX, shapeY);
    }
    shape.close();
    return shape;
  }

  Path drawCone(double radius, double angle) {
    angle /= 2;
    final shape = Path();
    Offset firstPoint = const Offset(0, 0);
    Offset secondPoint = Offset(
        radius * math.cos(radians(-angle)), radius * math.sin(radians(-angle)));
    Offset thirdPoint = Offset(
        radius * math.cos(radians(angle)), radius * math.sin(radians(angle)));
    // var rect = Rect.fromCircle(
    //   center: const Offset(0, 0),
    //   radius: radius,
    // );

    shape.moveTo(firstPoint.dx, firstPoint.dy);
    shape.lineTo(secondPoint.dx, secondPoint.dy);
    shape.arcToPoint(thirdPoint, radius: Radius.circular(radius));

    shape.close();
    return shape;
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) {
    return oldDelegate.waveRadius != waveRadius ||
        oldDelegate.map.hashCode != map.hashCode;
  }
}

class Map extends StatefulWidget {
  const Map({super.key, required this.map, this.showGrid});
  final ui.Image map;
  final showGrid;

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> with SingleTickerProviderStateMixin {
  double waveRadius = 0.0;
  double waveGap = 7.0;
  late Animation<double> _animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween(begin: 0.0, end: waveGap).animate(controller)
      ..addListener(() {
        setState(() {
          waveRadius = _animation.value;
        });
      });
    return Provider.of<OdomMsgProvider>(context).odometry == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : FittedBox(
            child: SizedBox(
              width: widget.map.width.toDouble(),
              height: widget.map.height.toDouble(),
              child: CustomPaint(
                painter: MapPainter(
                  map: widget.map,
                  debugGrig: widget.showGrid,
                  waveRadius: waveRadius,
                  waveAccentColor: Theme.of(context).highlightColor,
                  waveColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.amberAccent
                      : Colors.cyanAccent,
                  robotOdom: Provider.of<OdomMsgProvider>(context).odometry!,
                  // waypoints: Provider.of<WaypointProvider>(context).waypoints,
                  // activeWaypoint: Provider.of<W>(context).activeWaypoint
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
