import 'dart:ui';

class Waypoint {
  String name;
  Color color;
  double x;
  double y;
  double radius;

  Waypoint(
      {required this.name,
      required this.color,
      required this.x,
      required this.y,
      this.radius = 0.0});

  toJSONEencodable() {
    Map<String, dynamic> encoded = {};

    encoded['name'] = name;
    encoded['color'] = color;
    encoded['x'] = x;
    encoded['y'] = y;
    encoded['radius'] = radius;

    return encoded;
  }
}

class WaypointList {
  List<Waypoint> waypoints;

  WaypointList(this.waypoints);

  toJSONEencodable() {
    return waypoints.map((item) {
      return item.toJSONEencodable();
    }).toList();
  }
}
