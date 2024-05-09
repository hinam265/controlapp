class Angular {
  double x;
  double y;
  double z;

  Angular({required this.x, required this.y, required this.z});
}

class Linear {
  double x;
  double y;
  double z;

  Linear({required this.x, required this.y, required this.z});
}

class Twist {
  Angular angular;
  Linear linear;

  Twist({required this.angular, required this.linear});
}
