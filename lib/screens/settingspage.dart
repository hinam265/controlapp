import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:controlapp/components/listtiletextfield.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:controlapp/components/shadowline.dart';
import 'package:controlapp/providers/settingsprovider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark),
      child: Theme(
        data: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context)
                .copyWith(primaryColor: Theme.of(context).primaryColor)
            : Theme.of(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(0), child: ShadowLine()),
            toolbarHeight:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? null
                    : 45,
            backgroundColor: Theme.of(context).canvasColor,
            title: const Text('Settings'),
          ),
          body: ListView(
            children: [
              //App Settings
              const ListTile(
                  leading: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.apps),
                  ),
                  title: Text('App Settings'),
                  subtitle: Text('Theme Settings')),
              Consumer<SettingsProvider>(
                builder: (context, settingsProvider, child) => RadioListTile(
                  groupValue: settingsProvider.appTheme,
                  activeColor: Theme.of(context).highlightColor,
                  onChanged: (value) {
                    settingsProvider.setTheme(value!);
                  },
                  title: const Text('Light theme'),
                  value: ThemeMode.light,
                ),
              ),
              Consumer<SettingsProvider>(
                builder: (context, settingsProvider, child) => RadioListTile(
                  groupValue: settingsProvider.appTheme,
                  activeColor: Theme.of(context).highlightColor,
                  onChanged: (value) {
                    settingsProvider.setTheme(value!);
                  },
                  title: const Text('Dark theme'),
                  value: ThemeMode.dark,
                ),
              ),
              Consumer<SettingsProvider>(
                builder: (context, settingsProvider, child) => RadioListTile(
                  groupValue: settingsProvider.appTheme,
                  activeColor: Theme.of(context).highlightColor,
                  onChanged: (value) {
                    settingsProvider.setTheme(value!);
                  },
                  title: const Text('System theme'),
                  value: ThemeMode.system,
                ),
              ),

              //Ros Settings
              const SettingsDivider(),
              ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.desktopTower),
                  ),
                  title: const Text('ROS Settings'),
                  subtitle:
                      const Text('Settings for the Robot Operating System')),
              ListTileTextField(
                icon: Icon(MdiIcons.server),
                title: const Text('Main Server (IP)'),
                onChanged: (str) {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .setIpAdressMainServer(str);
                },
                textfieldcontroller: TextEditingController()
                  ..text = Provider.of<SettingsProvider>(context, listen: false)
                      .ipAdressMainServer,
              ),
              ListTileTextField(
                icon: Icon(MdiIcons.devices),
                title: const Text('Device (IP)'),
                onChanged: (str) {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .setIpAdressDevice(str);
                },
                textfieldcontroller: TextEditingController()
                  ..text = Provider.of<SettingsProvider>(context, listen: false)
                      .ipAdressDevice,
              ),
              ListTileTextField(
                icon: Icon(MdiIcons.cube),
                title: const Text('Odometry Topic'),
                onChanged: (str) {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .setTopicOdometry(str);
                },
                textfieldcontroller: TextEditingController()
                  ..text = Provider.of<SettingsProvider>(context, listen: false)
                      .topicOdometry,
              ),
              ListTileTextField(
                icon: Icon(MdiIcons.speedometer),
                title: const Text('Velocity Topic'),
                onChanged: (str) {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .setTopicVelocity(str);
                },
                textfieldcontroller: TextEditingController()
                  ..text = Provider.of<SettingsProvider>(context, listen: false)
                      .topicVelocity,
              ),
              ListTileTextField(
                icon: Icon(MdiIcons.earthBox),
                title: const Text('Map Topic'),
                textfieldcontroller: TextEditingController()
                  ..text = Provider.of<SettingsProvider>(context, listen: false)
                      .topicMap,
                onChanged: (str) {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .setTopicMap(str);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 10,
      thickness: 2,
    );
  }
}
