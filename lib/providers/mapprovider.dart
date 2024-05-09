import 'dart:async';

import 'package:controlapp/messages/occupancygrid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MapMsgProvider extends ChangeNotifier {
  OccupancyGrid? _mapImage;
  OccupancyGrid? get mapImage => _mapImage;

  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> _mapStream;

  MapMsgProvider() {
    _listenToMap();
  }

  void _listenToMap() {
    _mapStream = _db.child('map').onValue.listen((event) {
      final mapData = event.snapshot.value;
      _mapImage = OccupancyGrid.fromJson(mapData as Map<dynamic, dynamic>);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _mapStream.cancel();
    super.dispose();
  }
}
