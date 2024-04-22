class OdometryMsg {
  final double positionX;
  final double positionY;
  final double positionZ;
  final double orientationX;
  final double orientationY;
  final double orientationZ;
  final double orientationW;

  final double linearX;
  final double linearY;
  final double linearZ;
  final double angularX;
  final double angularY;
  final double angularZ;

  OdometryMsg({
    required this.positionX,
    required this.positionY,
    required this.positionZ,
    required this.orientationX,
    required this.orientationY,
    required this.orientationZ,
    required this.orientationW,
    required this.linearX,
    required this.linearY,
    required this.linearZ,
    required this.angularX,
    required this.angularY,
    required this.angularZ,
  });

  factory OdometryMsg.fromRTDB(Map<String, dynamic> data) {
    return OdometryMsg(
      positionX: data['pose']['pose']['position']['x'] ?? 0.0,
      positionY: data['pose']['pose']['position']['y'] ?? 0.0,
      positionZ: data['pose']['pose']['position']['z'] ?? 0.0,
      orientationX: data['pose']['pose']['orientation']['x'] ?? 0.0,
      orientationY: data['pose']['pose']['orientation']['y'] ?? 0.0,
      orientationZ: data['pose']['pose']['orientation']['z'] ?? 0.0,
      orientationW: data['pose']['pose']['orientation']['w'] ?? 0.0,
      linearX: data['twist']['twist']['linear']['x'] ?? 0.0,
      linearY: data['twist']['twist']['linear']['y'] ?? 0.0,
      linearZ: data['twist']['twist']['linear']['z'] ?? 0.0,
      angularX: data['twist']['twist']['angular']['x'] ?? 0.0,
      angularY: data['twist']['twist']['angular']['y'] ?? 0.0,
      angularZ: data['twist']['twist']['angular']['z'] ?? 0.0,
    );
  }
}
