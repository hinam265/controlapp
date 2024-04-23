import 'dart:async';
import 'dart:ui' as ui;

import 'package:controlapp/models/mapmsgextension.dart';
import 'package:controlapp/models/occupancygrid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MapMsgProvider extends ChangeNotifier {
  late OccupancyGrid _mapImage;
  OccupancyGrid get mapImage => _mapImage;

  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> _mapStream;

  MapMsgProvider() {
    _listenToMap();
  }

  void _listenToMap() {
    _mapStream = _db.child('map').onChildChanged.listen((event) {
      final mapData = event.snapshot.value;
      _mapImage = OccupancyGrid.fromJson(mapData as Map<String, dynamic>);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _mapStream.cancel();
    super.dispose();
  }

  Future<ui.Image> getMapAsImage(final Color fill, final Color border) {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
        _mapImage.toRGBA(fill: fill, border: border),
        _mapImage.mapMetaData.height,
        _mapImage.mapMetaData.width,
        ui.PixelFormat.rgba8888,
        completer.complete);
    return completer.future;
  }
}
