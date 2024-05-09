import 'pose.dart';
import 'twist.dart';

class Stamp {
  int nanosec;
  int sec;

  Stamp({required this.nanosec, required this.sec});
}

class Header {
  String frameId;
  Stamp stamp;

  Header({required this.frameId, required this.stamp});
}

class Odometry {
  Header header;
  Pose pose;
  Twist twist;

  Odometry({required this.header, required this.pose, required this.twist});

  factory Odometry.fromJson(Map<dynamic, dynamic> response) {
    return Odometry(
      header: Header(
        frameId: response["header"]["frame_id"],
        stamp: Stamp(
          nanosec: response["header"]["stamp"]["nanosec"],
          sec: response["header"]["stamp"]["sec"],
        ),
      ),
      pose: Pose(
        position: Position(
          x: response["pose"]["pose"]["position"]["x"],
          y: response["pose"]["pose"]["position"]["y"],
          z: response["pose"]["pose"]["position"]["z"],
        ),
        orientation: Orientations(
          x: response["pose"]["pose"]["orientation"]["x"],
          y: response["pose"]["pose"]["orientation"]["y"],
          z: response["pose"]["pose"]["orientation"]["z"],
          w: response["pose"]["pose"]["orientation"]["w"],
        ),
      ),
      twist: Twist(
        angular: Angular(
          x: response["twist"]["twist"]["angular"]["x"],
          y: response["twist"]["twist"]["angular"]["y"],
          z: response["twist"]["twist"]["angular"]["z"],
        ),
        linear: Linear(
          x: response["twist"]["twist"]["linear"]["x"],
          y: response["twist"]["twist"]["linear"]["y"],
          z: response["twist"]["twist"]["linear"]["z"],
        ),
      ),
    );
  }
}
