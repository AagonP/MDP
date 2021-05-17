import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../Models/device.dart';

class DisplayBox extends StatefulWidget {
  final icon;
  final text;
  final value;
  const DisplayBox({
    Key? key,
    this.icon,
    this.text,
    this.value,
  }) : super(key: key);

  @override
  _DisplayBoxState createState() => _DisplayBoxState();
}

class _DisplayBoxState extends State<DisplayBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Device>(
      builder: (contex, device, child) => Container(
        child: Column(
          children: [
            Icon(Icons.analytics),
            Text(device.name),
            Text(device.data),
          ],
        ),
      ),
    );
  }
}
