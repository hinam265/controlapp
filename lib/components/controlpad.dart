import 'dart:math';
import 'package:flutter/material.dart';

class ControlPad extends StatefulWidget {
  final double baseSize;
  final double stickSize;
  final void Function(Offset) onStickMove;

  const ControlPad(
      {super.key,
      required this.baseSize,
      required this.stickSize,
      required this.onStickMove});

  @override
  State<ControlPad> createState() =>
      _ControlPadState(baseSize, stickSize, onStickMove);
}

class _ControlPadState extends State<ControlPad> {
  final double baseSize;
  final double stickSize;
  var tapCount = 0;
  Offset offset = const Offset(0, 0);
  var angle = 0;
  var radius;
  bool inMotion = false;

  void Function(Offset) onStickMove;

  _ControlPadState(this.baseSize, this.stickSize, this.onStickMove) {
    radius = baseSize / 2;
    // msg = GeometryMsgsTwist();
    // //ANDROID DEVICE DEFAULT IP WHEN TETHERING: 192.168.43.1
    // var config =
    //     RosNode('http://192.168.43.145:11311/', '192.168.43.92', 51235);
    // var publisher = RosPublisher('sticky_publisher', 'cmd_vel', msg, config,
    //     publishInterval: Duration(milliseconds: 100));
    // publisher.register();

    // onStickMove = (offset) {
    // msg.linear.x = -offset.dy * 0.4;
    // msg.angular.z = -offset.dx * 1.5;
    //if (offset.dy < 0) msg.angular.z *= -1;
    // print(offset.dy.toString());
    // };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Button pressed ${++tapCount}');
      },
      onPanUpdate: (start) {
        inMotion = true;
        var local = start.localPosition.translate(-radius, -radius);
        var x = cos(local.direction);
        var y = sin(local.direction);
        var maxDistance = (local.distance / radius);
        maxDistance = maxDistance > 1 ? 1 : maxDistance;
        onStickMove(Offset(x, y) * maxDistance);
        if (local.distance >= radius) {
          local = Offset(x, y) * radius;
        }
        setState(() {
          offset = local;
        });
      },
      onPanEnd: (_) {
        inMotion = false;
        onStickMove(const Offset(0, 0));
        setState(() {
          offset = const Offset(0, 0);
        });
      },
      child: Material(
        //OUTER RADIUS
        shape: CircleBorder(
            side: BorderSide(width: 2, color: Colors.grey.withAlpha((80)))),
        color: Colors.white.withAlpha(0),
        child: Container(
          height: baseSize,
          width: baseSize,
          child: Center(
            child: Stack(
              children: <Widget>[
                //Middle RADIUS
                Center(
                  child: Material(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 4, color: Colors.grey.withAlpha((20)))),
                    color: Colors.grey.withAlpha(0),
                    child: Container(
                      height: baseSize * 0.7,
                      width: baseSize * 0.7,
                    ),
                  ),
                ),
                //Inner RADIUS
                Center(
                  child: Material(
                    shape: const CircleBorder(),
                    color: Colors.grey.withAlpha(30),
                    child: Container(
                      height: stickSize,
                      width: stickSize,
                    ),
                  ),
                ),
                Center(
                  child: Transform.translate(
                    offset: offset,
                    child: Material(
                      shape: const CircleBorder(
                          side: BorderSide(width: 2, color: Colors.black38)),
                      color: Colors.grey,
                      //color: Color.fromRGBO(89, 89, 89, 1)
                      elevation: 4.0,
                      child: Container(
                        height: inMotion ? stickSize / 2 : stickSize,
                        width: inMotion ? stickSize / 2 : stickSize,
                        child: Center(
                          child: Icon(
                            Icons.blur_on,
                            size: inMotion
                                ? stickSize / 2 / 1.4
                                : stickSize / 1.4,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
