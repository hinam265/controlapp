import 'package:controlapp/providers/mapprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'providers/appstateprovider.dart';
import 'providers/settingsprovider.dart';
import 'providers/odomprovider.dart';

import 'screens/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ChangeNotifierProvider(create: (_) => OdomMsgProvider()),
      ChangeNotifierProvider(create: (_) => MapMsgProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.light,
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.blue[50],
        canvasColor: const Color.fromRGBO(245, 245, 245, 1),
        appBarTheme: const AppBarTheme(elevation: 0),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        highlightColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
            background: Colors.white,
            brightness: Brightness.light,
            secondary: Colors.blue,
            primary: Colors.white),
      ),
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(40, 40, 40, 1),
        canvasColor: const Color.fromRGBO(60, 60, 60, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(40, 40, 40, 1),
        appBarTheme: const AppBarTheme(elevation: 0),
        highlightColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
            background: const Color.fromRGBO(50, 50, 50, 1),
            brightness: Brightness.dark,
            secondary: Colors.amber,
            primary: const Color.fromRGBO(40, 40, 40, 1)),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
