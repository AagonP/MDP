import 'package:flutter/cupertino.dart';

import '../constant.dart';

class HeaderText extends StatelessWidget {
  final alignment;
  final text;
  const HeaderText({
    Key? key,
    this.alignment,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 0),
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
