import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:controlapp/providers/settingsprovider.dart';

class ListTileTextField extends StatelessWidget {
  final Function onChanged;
  final TextEditingController textfieldcontroller;
  final Icon icon;
  final Widget title;

  const ListTileTextField({
    super.key,
    required this.onChanged,
    required this.textfieldcontroller,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) => ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
        title: title,
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 2),
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    // style: const BorderStyle.none,
                    color: Colors.grey,
                    width: 0.1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    // style: const BorderStyle.none,
                    color: Colors.grey,
                    width: 0.1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    color: Colors.grey,
                    width: 0.1,
                  ),
                ),
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                isDense: true),
            controller: textfieldcontroller,
            onChanged: onChanged as void Function(String)?,
          ),
        ),
      ),
    );
  }
}
