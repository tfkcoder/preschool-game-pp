// ignore: file_names

import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String itemName;
  const MenuItem(this.itemName, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          child: Text(itemName),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
