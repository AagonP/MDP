import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchResultScreen extends StatelessWidget {
  final searchKey;

  const SearchResultScreen({Key? key, required this.searchKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Body(
          searchKey: searchKey,
        ),
      ),
    );
  }
}
