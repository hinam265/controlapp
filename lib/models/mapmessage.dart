import 'dart:typed_data';

class MapMsg {
  final int height;
  final int width;
  final Int8List mapdata;

  MapMsg({
    required this.height,
    required this.width,
    required this.mapdata,
  });

  factory MapMsg.fromRTDB(Map<String, dynamic> data) {
    return MapMsg(
      height: data['info']['height'] as int,
      width: data['info']['width'] as int,
      // mapdata: Int8List.fromList(data['data'] as Int8List),
      mapdata: Int8List.fromList(List<int>.from(data['data'] as List<dynamic>)),
    );
  }
}
