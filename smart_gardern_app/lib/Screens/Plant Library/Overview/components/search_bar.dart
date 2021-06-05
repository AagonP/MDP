import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/SearchResult/search_result_screen.dart';
import '../../../../constant.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
      width: size.width * 0.6,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(29)),
      child: TextField(
        controller: searchController,
        onEditingComplete: () {
          //TODO: Refactor
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SearchResultScreen(searchKey: searchController.text);
              },
            ),
          );
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
