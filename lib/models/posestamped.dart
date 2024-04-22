class PoseStamped {
  double positionX;
  double positionY;
  double orientationW;
  String frame_id;

  PoseStamped({
    required this.positionX,
    required this.positionY,
    required this.orientationW,
    required this.frame_id,
  });
}
