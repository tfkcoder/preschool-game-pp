// ignore: file_names
import 'package:flutter/material.dart';

class ToolIcon extends StatelessWidget {
  final IconData iconData;
  final bool isActive;
  const ToolIcon(this.iconData, {super.key, this.isActive = false});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0.9,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      color: isActive ? const Color(0x00C0C0C0) : const Color(0xFFC0C0C0),
      child: IconButton(icon: Icon(iconData), onPressed: null),
    );
  }
}
