import 'package:flutter/material.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SearchBarScreen extends StatefulWidget {
  @override
  _SearchBarScreen createState() => _SearchBarScreen();
}

class _SearchBarScreen extends State<SearchBarScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        title: Text('Chatbot'),
      ),
      body: Stack(children: [
        Container(
        child: Column(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
            width: size.width * 0.88,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(29)),
            child: TextField(

              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
              ),
            ),
          )
              ],
            ),
          ),
          Column(children: [
            Container(
              child: Column(children: [
                Align(alignment: Alignment.topLeft, child: Text('Admin 1', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white, fontSize: 18)),),
                Row(children: [
                  Text('Me: Texting 1234',style: TextStyle(color: Colors.white)),
                  Text('1:13 pm', style: TextStyle(color: Colors.white))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,)
              ],
             
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding,
                                  horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                                color:  Color(0xFF0C9869),
                                borderRadius: BorderRadius.circular(16),
                              ),
            ),
            Container(
              child: Column(children: [
                Align(alignment: Alignment.topLeft, child: Text('Admin 2', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white, fontSize: 18)),),
                Row(children: [
                  Text('Admin 2: Texting 1234',style: TextStyle(color: Colors.white)),
                  Text('Wed', style: TextStyle(color: Colors.white))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,)
              ],
             
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                                color:  Color(0xFF0C9869),
                                borderRadius: BorderRadius.circular(16),
                              ),
            ),
            Container(
              child: Column(children: [
                Align(alignment: Alignment.topLeft, child: Text('Admin 3', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),),
                Row(children: [
                  Text('Me: Texting 1234',style: TextStyle(color: Colors.white)),
                  Text('May 1', style: TextStyle(color: Colors.white))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,)
              ],
             
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                                color:  Color(0xFF0C9869),
                                borderRadius: BorderRadius.circular(16),
                              ),
            ),
            Container(
              child: Column(children: [
                Align(alignment: Alignment.topLeft, child: Text('Admin 4', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),),
                Row(children: [
                  Text('Admin 3: Texting 1234',style: TextStyle(color: Colors.white)),
                  Text('May 1', style: TextStyle(color: Colors.white))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,)
              ],
             
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                                color:  Color(0xFF0C9869),
                                borderRadius: BorderRadius.circular(16),
                              ),
            ),
          ],
          ), 
        ],
        ),   
        padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
      ),
      Container(
        alignment: Alignment.bottomRight,
        child:IconButton(
                    iconSize: size.height * 0.05,
                    icon: SvgPicture.asset('assets/icons/plus.svg',
                        color: Colors.black),
                    tooltip: 'Control Device',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) {
                      //     return DeviceControl();
                      //   }),
                      // );
                    },
                  ), )
      ],)
    );
  }
}
