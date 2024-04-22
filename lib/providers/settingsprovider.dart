import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  int _themeModeIndex = 2;
  int get themeModeIndex => _themeModeIndex;

  ThemeMode _appTheme = ThemeMode.system;
  ThemeMode get appTheme => _appTheme;

  void _initializeTheme() {
    switch (_themeModeIndex) {
      case 0:
        {
          _appTheme = ThemeMode.light;
          break;
        }
      case 1:
        {
          _appTheme = ThemeMode.dark;
          break;
        }
      case 2:
        {
          _appTheme = ThemeMode.system;
          break;
        }
    }
  }

  void setTheme(ThemeMode value) {
    _appTheme = value;
    notifyListeners();
  }

  Future<void> loadSettings() async {
    // Load settings from shared preferences
    _initializeTheme();
    notifyListeners();
  }

  String _ipAdressMainServer = 'http://192.168.1.105:11311/';
  String get ipAdressMainServer => _ipAdressMainServer;

  String _ipAdressDevice = '192.168.1.109';
  String get ipAdressDevice => _ipAdressDevice;

  String _topicOdometry = 'odom';
  String get topicOdometry => _topicOdometry;

  String _topicVelocity = 'cmd_vel';
  String get topicVelocity => _topicVelocity;

  String _topicMap = 'map';
  String get topicMap => _topicMap;

  void setIpAdressMainServer(String str) {
    print('Set ip main server to $str');
    _ipAdressMainServer = str;
  }

  void setIpAdressDevice(String str) {
    _ipAdressDevice = str;
  }

  void setTopicOdometry(String str) {
    _topicOdometry = str;
  }

  void setTopicVelocity(String str) {
    _topicVelocity = str;
  }

  void setTopicMap(String str) {
    _topicMap = str;
  }
}
