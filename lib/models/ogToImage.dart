import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:controlapp/models/occupancygrid.dart';
import 'package:controlapp/models/mapmsgextension.dart';

Future<ui.Image> getMapAsImage(
    final OccupancyGrid og, final Color fill, final Color border) {
  final completer = Completer<ui.Image>();
  ui.decodeImageFromPixels(
      og.toRGBA(border: border, fill: fill),
      og.mapMetaData.width,
      og.mapMetaData.height,
      ui.PixelFormat.rgba8888,
      completer.complete);
  return completer.future;
}
