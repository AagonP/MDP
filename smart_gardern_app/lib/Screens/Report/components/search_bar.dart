import 'package:flutter/material.dart';
import '../../../constant.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();
  void changing(str) {
    ReportNotifier reportNotifier =
        Provider.of<ReportNotifier>(context, listen: false);
    reportNotifier.searching = str;
    getReports(reportNotifier, reportNotifier.currentList,
        reportNotifier.currentsearchValue, reportNotifier.currentorderValue);
  }

  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
      width: size.width * 0.88,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(29)),
      child: TextField(
        controller: searchController,
        onEditingComplete: () {
          changing(searchController.text);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
