import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:controlapp/components/controlpad.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:controlapp/screens/mappage.dart';
import 'package:flutter/widgets.dart';

class ControlPage extends StatelessWidget {
  ControlPage({super.key});

  final database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * (1 / 2),
          width: MediaQuery.of(context).size.width,
          child: MapPage(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Container(
              color: Color.fromARGB(255, 31, 42, 161),
              child: const _JoystickConfigurationPortrait()),
        )
      ],
    ));
  }
}

// class _JoystickConfigurationLandscape extends StatelessWidget {
//   const _JoystickConfigurationLandscape({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(40.0),
//       child: Container(
//         color: Colors.transparent,
//         // height: MediaQuery.of(context).size.height / 4,
//         child: ControlPad(
//           baseSize: MediaQuery.of(context).size.height / 2.5,
//           stickSize: MediaQuery.of(context).size.height / 2.5 * 0.4,
//           onStickMove: (offset) {
//             joystickMove(offset, context);
//           },
//         ),
//       ),
//     );
//   }
// }

class _JoystickConfigurationPortrait extends StatelessWidget {
  const _JoystickConfigurationPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      // color: Theme.of(context).canvasColor,
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: ControlPad(
          baseSize: MediaQuery.of(context).size.height / 3.9,
          stickSize: MediaQuery.of(context).size.height / 3.9 * 0.4,
          onStickMove: (offset) {
            joystickMove(offset, context);
          },
        ),
      ),
    );
  }
}

void joystickMove(Offset offset, BuildContext context) {
  final cmdVel = FirebaseDatabase.instance.ref().child('cmd_vel');

  cmdVel.set({'linear': -offset.dy * 0.4, 'angular': -offset.dx});
}
