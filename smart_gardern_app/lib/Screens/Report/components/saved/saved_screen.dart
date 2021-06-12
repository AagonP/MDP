import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/saved_body.dart';
import 'package:smart_gardern_app/Screens/Report/report_screen.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreen createState() => _SavedScreen();
}

class _SavedScreen extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double wid = size.width.toDouble();
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        title: Text('Saved Report'),
      ),
      body: SavedBody(),
    );
  }
}
