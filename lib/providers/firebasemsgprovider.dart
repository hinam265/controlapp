import 'dart:async';
import 'dart:ui' as ui;

import 'package:controlapp/models/mapmsgextension.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:controlapp/models/odometrymessage.dart';
import 'package:controlapp/models/mapmessage.dart';

class FirebaseMsgProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  OdometryMsg? _odometry;
  OdometryMsg? get odometry => _odometry;

  late StreamSubscription<DatabaseEvent> _odometryStream;

  final _db = FirebaseDatabase.instance.ref();

  FirebaseMsgProvider() {
    _listenToOdometry();
    _listenToMap();
  }

  void _listenToOdometry() {
    _odometryStream = _db.child('odom').onChildChanged.listen((event) {
      final odomData = event.snapshot.value!;
      final _odometry = OdometryMsg.fromRTDB(odomData as Map<String, dynamic>);

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _odometryStream.cancel();
    super.dispose();
  }

  MapMsg? _mapImage;
  MapMsg? get mapImage => _mapImage;

  late StreamSubscription<DatabaseEvent> _mapStream;

  void _listenToMap() {
    _mapStream = _db.child('map').onChildChanged.listen((event) {
      final mapData = event.snapshot.value!;
      _mapImage = MapMsg.fromRTDB(mapData as Map<String, dynamic>);
      notifyListeners();
    });
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
