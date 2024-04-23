// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:controlapp/components/shadowline.dart';
// import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:controlapp/providers/appstateprovider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'controlpage.dart';
import 'mappage.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<Widget> appPages = [ControlPage(), MapPage()];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
      child: Scaffold(
          extendBody: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: ShadowLine(),
            ),
            toolbarHeight:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? null
                    : 48,
            title: Consumer<AppStateProvider>(
              builder: (context, appState, child) {
                return Text(
                    Provider.of<AppStateProvider>(context).activePageIndex == 0
                        ? 'Controller'
                        : 'Map',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black54
                          : Colors.white,
                    ));
              },
            ),
            actions: [
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? _NavigationIconsRow()
                  : const SizedBox(),
              IconButton(
                  icon: Icon(MdiIcons.refresh,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black54
                          : Colors.white),
                  onPressed: () {
                    // Provider.of<AppStateProvider>(context, listen: false)
                    //     .setActivePage(0);
                  }),
              IconButton(
                  icon: Icon(MdiIcons.stop,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black54
                          : Colors.white),
                  onPressed: () {
                    // Provider.of<AppStateProvider>(context, listen: false)
                    //     .setActivePage(0);
                  }),
              // IconButton(
              //     icon: Icon(MdiIcons.cog,
              //         color: Theme.of(context).brightness == Brightness.light
              //             ? Colors.black54
              //             : Colors.white),
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: ((context) => const SettingsPage())));
              //     }),
            ],
          ),
          bottomNavigationBar: MediaQuery.of(context).orientation ==
                  Orientation.portrait
              ? Consumer<AppStateProvider>(
                  builder: (BuildContext context, appStateProvider, child) {
                    return BottomNavigationBar(
                      backgroundColor: Theme.of(context).canvasColor,
                      selectedItemColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black54
                              : Colors.white,
                      unselectedItemColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black12
                              : Colors.white24,
                      elevation: 0,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedFontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize ??
                              10,
                      unselectedFontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize ??
                              10,
                      currentIndex: appStateProvider.activePageIndex,
                      onTap: (index) {
                        appStateProvider.setActivePage(index);
                      },
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.gamepad),
                          label: 'Control',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.near_me),
                          label: 'Map',
                        ),
                      ],
                    );
                  },
                )
              : const SizedBox(),
          body: Consumer<AppStateProvider>(
            builder: (context, provider, child) {
              return appPages[provider.activePageIndex];
            },
          )),
    );
  }
}

class _NavigationIconsRow extends StatelessWidget {
  const _NavigationIconsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: "Control",
          icon: Icon(MdiIcons.gamepadUp,
              // size: 30,
              color: Provider.of<AppStateProvider>(context, listen: true)
                          .activePageIndex ==
                      1
                  ? Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Colors.white
                  : Theme.of(context).brightness == Brightness.light
                      ? Colors.black12
                      : Colors.white24),
          onPressed: () {
            Provider.of<AppStateProvider>(context, listen: false)
                .setActivePage(1);
          },
        ),
        const VerticalDivider(),
        IconButton(
          tooltip: "Map",
          icon: Icon(MdiIcons.earthBox,
              // size: 30,
              color: Provider.of<AppStateProvider>(context, listen: true)
                          .activePageIndex ==
                      2
                  ? Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Colors.white
                  : Theme.of(context).brightness == Brightness.light
                      ? Colors.black12
                      : Colors.white24),
          onPressed: () {
            Provider.of<AppStateProvider>(context, listen: false)
                .setActivePage(2);
          },
        ),
        const VerticalDivider(
          width: 0,
        ),
      ],
    );
  }
}
