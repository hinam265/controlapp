import 'package:controlapp/screens/controlpage.dart';
import 'package:controlapp/screens/mappage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppStateProvider extends ChangeNotifier {
  var _activePageIndex = 0;
  static final _appPages = [ControlPage(), MapPage()];

  final _navigationBarPageController =
      PageController(initialPage: 0, keepPage: true);

  void setActivePage(int index) {
    if (index != _activePageIndex) {
      _activePageIndex = index;
      // Navigation with PagedView
      // if (WidgetsBinding.instance.disableAnimations) {
      //   _navigationBarPageController.jumpToPage(index);
      // } else {
      //   _navigationBarPageController.animateToPage(index,
      //       duration: Duration(milliseconds: 400), curve: Curves.easeOutQuad);
      // }
      notifyListeners();
    }
  }

  int get activePageIndex => _activePageIndex;

  PageController get navigationBarPageController =>
      _navigationBarPageController;
  List<Widget> get appPages => _appPages;
}
