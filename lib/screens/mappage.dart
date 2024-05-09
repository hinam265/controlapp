import 'dart:ui' as ui;

import 'package:controlapp/components/mappainter.dart';
import 'package:controlapp/providers/mapprovider.dart';
import 'package:flutter/material.dart';

import 'package:controlapp/messages/ogToImage.dart';

import 'package:provider/provider.dart';
import 'package:firebase_performance/firebase_performance.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  // Trace gridMapTrace = FirebasePerformance.instance.newTrace('gridMapTrace');

  ui.Image? previousMap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Provider.of<MapMsgProvider>(context).mapImage == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : InteractiveViewer(
                    maxScale: 10,
                    minScale: 0.1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: FutureBuilder(
                            future: getMapAsImage(
                                Provider.of<MapMsgProvider>(context).mapImage!,
                                Theme.of(context).primaryColor,
                                Colors.black),
                            initialData: previousMap,
                            builder: (_, img) {
                              previousMap = img.data;
                              return img.data == null
                                  ? const CircularProgressIndicator()
                                  : Map(map: img.data!, showGrid: true);
                            }),
                      ),
                    ),
                  )),
        // Positioned(child: StatusInfo()),
        // Positioned(bottom: 52, left: 0, child: MapShelfButtons(),),
        // Positioned(bottom: 0, left: 0, right: 0, child: WaypointShelf()),
        // Positioned( bottom: 45, right: 0, left: 0,  child: ShadowLine(),),
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   child: Padding(
        //     padding: const EdgeInsets.only(bottom: 55, right: 10),
        //     child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: 8),
        //         child: FloatingActionButton(
        //             backgroundColor:
        //                 Theme.of(context).chipTheme.backgroundColor,
        //             heroTag: null,
        //             tooltip: S?.of(context)?.pageMapButtonFloating,
        //             onPressed: () {
        //               showDialog(
        //                   context: context, builder: (_) => WaypointDialog());
        //             },
        //             child: Icon(MdiIcons.plus,
        //                 color: Theme.of(context).brightness == Brightness.light
        //                     ? Colors.black45
        //                     : Colors.white),
        //             mini: false),
        //       ),

        //       // FloatingActionButton(
        //       //     heroTag: null,
        //       //     backgroundColor: Theme.of(context).chipTheme.backgroundColor,
        //       //     elevation: Provider.of<RosProvider>(context).mapImageAvailable
        //       //         ? null
        //       //         : 0,
        //       //     tooltip: 'Przejedź robotem do wybranego znacznika',
        //       //     onPressed: () {},
        //       //     child: Icon(Icons.directions,
        //       //         color: Provider.of<RosProvider>(context).mapImageAvailable
        //       //             ? Theme.of(context).brightness == Brightness.light
        //       //                 ? Colors.black45
        //       //                 : Colors.white
        //       //             : Theme.of(context).brightness == Brightness.light
        //       //                 ? Colors.black12
        //       //                 : Colors.white24),
        //       //     mini: false),
        //     ]),
        //   ),
        // )
      ],
    );
  }
}
