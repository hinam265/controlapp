import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:controlapp/models/odometry.dart';

class OdomMsgProvider extends ChangeNotifier {
  late Odometry _odometry;
  Odometry get odometry => _odometry;

  late StreamSubscription<DatabaseEvent> _odometryStream;
  final _db = FirebaseDatabase.instance.ref();

  OdomMsgProvider() {
    _listenToOdometry();
  }

  void _listenToOdometry() {
    _odometryStream = _db.child('odom').onChildChanged.listen((event) {
      final odomData = event.snapshot.value;
      _odometry = Odometry.fromJson(odomData as Map<String, dynamic>);

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _odometryStream.cancel();
    super.dispose();
  }
}
