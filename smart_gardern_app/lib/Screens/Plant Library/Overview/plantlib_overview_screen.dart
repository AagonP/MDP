import 'package:flutter/material.dart';

import 'components/body.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Body(),
      ),
    );
  }
}
