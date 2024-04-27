import 'dart:async';
import 'dart:ui' as ui;
import 'package:controlapp/models/ogToImage.dart';
import 'package:controlapp/providers/mapprovider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:controlapp/providers/mapprovider.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:controlapp/models/occupancygrid.dart';
// import 'dart:convert';
import 'package:controlapp/models/occupancyGridToImageBytes.dart';
import 'dart:typed_data';
import 'package:controlapp/models/pose.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final database = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> _streamSubscription;
  late OccupancyGrid _mapImage;
  late Uint8List pngImg = occupancyGridToImageBytes(OccupancyGrid(
      header: Header(frameId: '0', stamp: Stamp(nanosec: 0, sec: 0)),
      data: List<int>.filled(100, 100, growable: true),
      mapMetaData: MapMetaData(
        height: 600,
        width: 600,
        resolution: 0,
        origin: Pose(
            position: Position(x: 0, y: 0, z: 0),
            orientation: Orientations(x: 0, y: 0, z: 0, w: 0)),
      )));
  // late Uint8List pngImg;
  late String _displaytext = 'No data';
  ui.Image? previousMap;

  @override
  void initState() {
    super.initState();
    _listentoRTDB();
  }

  void _listentoRTDB() {
    _streamSubscription = database.child('map').onValue.listen((event) {
      final mapData = event.snapshot.value as Map<dynamic, dynamic>;

      _mapImage = OccupancyGrid.fromJson(mapData);
      final pngImgData = occupancyGridToImageBytes(_mapImage);

      final height = _mapImage.mapMetaData.height;
      final width = _mapImage.mapMetaData.width;
      setState(() {
        _displaytext = width.toString();
        pngImg = pngImgData;
        print(_displaytext);
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_displaytext),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
                bottom: 45,
                left: 0,
                right: 0,
                top: 0,
                child: Provider.of<MapMsgProvider>(context).mapImage == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : InteractiveViewer(
                        maxScale: 10,
                        child: SizedBox(
                          width: double.infinity,
                          child:
                              // Image.memory(pngImg)

                              Center(
                                  child: FutureBuilder(
                                      future: getMapAsImage(
                                          Provider.of<MapMsgProvider>(context)
                                              .mapImage!,
                                          Theme.of(context).primaryColor,
                                          Colors.black),
                                      initialData: previousMap,
                                      builder: (_, img) {
                                        previousMap = img.data;
                                        return img.data == null
                                            ? const CircularProgressIndicator()
                                            : MyPainter(map: img.data!);
                                      })),
                        ),
                      ))
          ],
        ));
  }
}

class MyPainter extends StatefulWidget {
  const MyPainter({super.key, required this.map});
  final ui.Image map;

  @override
  State<MyPainter> createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  // @override
  // void initState() {
  //   super.initState();
  //   loadImage();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCanvas(map: widget.map),
    );
  }
}

// void loadImage() {
//   decodeImageFromList()
// }

class MyCanvas extends CustomPainter {
  final ui.Image map;

  MyCanvas({super.repaint, required this.map});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(map, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
