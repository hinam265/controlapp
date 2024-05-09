class Position {
  double x;
  double y;
  double z;

  Position({required this.x, required this.y, required this.z});
}

class Orientations {
  double x;
  double y;
  double z;
  double w;

  Orientations(
      {required this.x, required this.y, required this.z, required this.w});
}

class Pose {
  Position position;
  Orientations orientation;

  Pose({required this.position, required this.orientation});
}
