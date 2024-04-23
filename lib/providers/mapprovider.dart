import 'dart:async';
import 'dart:ui' as ui;

import 'package:controlapp/models/mapmsgextension.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:controlapp/models/mapmessage.dart';

class MapMsgProvider extends ChangeNotifier {
  MapMsg? _mapImage;
  MapMsg? get mapImage => _mapImage;

  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> _mapStream;

  MapMsgProvider() {
    _listenToMap();
  }

  void _listenToMap() {
    _mapStream = _db.child('map').onValue.listen((event) {
      final mapData = event.snapshot.value!;
      _mapImage = MapMsg.fromRTDB(mapData as Map<String, dynamic>);
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
        _mapImage!.toRGBA(fill: fill, border: border),
        _mapImage!.height,
        _mapImage!.width,
        ui.PixelFormat.rgba8888,
        completer.complete);
    return completer.future;
  }
}
