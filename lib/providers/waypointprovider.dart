// import 'package:controlapp/models/waypoint.dart';
// import 'package:flutter/material.dart';
// import 'package:controlapp/models/posestamped.dart';

// class WaypointProvider extends ChangeNotifier {
//   WaypointList _waypoints;
//   WaypointList get waypoints => _waypoints;

//   WaypointProvider() : _waypoints = WaypointList([]) {
//     _waypoints = WaypointList([
//       Waypoint(name: 'K', color: Colors.green, x: 6, y: -1),
//       Waypoint(name: 'PG', color: Colors.yellow, x: 2.9, y: 2.3),
//       Waypoint(name: 'S', color: Colors.pink, x: -6, y: 3.11),
//       Waypoint(name: 'L', color: Colors.blue, x: 1, y: 2.6),
//     ]);
//   }

//   void addWaypoint(Waypoint waypoint) {
//     _waypoints.waypoints.add(waypoint);
//     notifyListeners();
//   }

//   void removeWaypoint(Waypoint waypoint) {
//     _waypoints.waypoints.remove(waypoint);
//     notifyListeners();
//   }

//   void editWaypoint(Waypoint original, Waypoint edited) {
//     var index =
//         _waypoints.waypoints.indexWhere((element) => element == original);
//     print('found the same waypoint');
//     _waypoints.waypoints.remove(original);
//     _waypoints.waypoints.insert(index, edited);
//     notifyListeners();
//   }
// }

// class ActiveWaypointProvider extends ChangeNotifier {
//   Waypoint _activeWaypoint;
//   Waypoint get activeWaypoint => _activeWaypoint;

//   PoseStamped _poseStamped;
//   PoseStamped get poseStamped => _poseStamped;

  
  
//   void setactiveWaypoint(Waypoint newWaypoint, BuildContext context) {
//     //Waypoint can be reseted to point on map if current goal is canceled
//     if (_activeWaypoint != newWaypoint) {
//       print('x:${newWaypoint.x}\ty:${newWaypoint.y}');
//       var _oldWaypoint = _activeWaypoint;
//       _activeWaypoint = newWaypoint;
//       _poseStamped
//         ..orientationW = 1
//         ..frame_id = 'map'
//         ..positionX = _activeWaypoint.x
//         ..positionY = _activeWaypoint.y;

//       notifyListeners();
//     }
//   }
// }
