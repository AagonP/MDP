import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/saved_data.dart';

class SavedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SavedData(),
        ],
      ),
    );
  }
}
