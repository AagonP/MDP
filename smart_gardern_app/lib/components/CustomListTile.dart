import 'package:flutter/material.dart';

import '../constant.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.text,
    this.imageURL,
    this.onTapHandler,
  }) : super(key: key);
  final text;
  final imageURL;
  final onTapHandler;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTapHandler();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(29),
                topRight: Radius.circular(29),
              ),
              child: Image.network(
                imageURL,
                fit: BoxFit.fill,
                width: size.width * 0.4,
                height: size.height * 0.2,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: size.height * 0.1 - kDefaultPadding * 2,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(29),
                  bottomRight: Radius.circular(29),
                ),
              ),
              child: Text(
                "$text",
                style: TextStyle(color: kTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
