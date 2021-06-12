import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_gardern_app/Screens/Device%20Control/device_control_screen.dart';
import 'package:smart_gardern_app/constant.dart';

import '../../components/rounded_button.dart';
import '../Plant Library/Overview/plantlib_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   child: RoundedButton(press: () {}, text: "Report management"),
                // ),
                // Container(
                //   child: RoundedButton(press: () {}, text: "Statistics"),
                // ),
                // Container(
                //   child: RoundedButton(press: () {}, text: "Control devices"),
                // ),
                // Container(
                //   child: RoundedButton(
                //       press: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) {
                //             return Overview();
                //           }),
                //         );
                //       },
                //       text: "Plant Library"),
                // ),
                // Container(
                //   child: RoundedButton(press: () {}, text: "Chatbox"),
                // ),
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.3,
                  margin: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                      horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: IconButton(
                    iconSize: size.height * 0.1,
                    icon: SvgPicture.asset('assets/icons/control.svg',
                        color: Colors.white),
                    tooltip: 'Control Device',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DeviceControl();
                        }),
                      );
                    },
                  ),
                ),

                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.3,
                  margin: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                      horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: IconButton(
                    iconSize: size.height * 0.1,
                    icon: SvgPicture.asset('assets/icons/book.svg',
                        color: Colors.white),
                    tooltip: 'Plant Library',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Overview();
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   child: RoundedButton(press: () {}, text: "Report management"),
                // ),
                // Container(
                //   child: RoundedButton(press: () {}, text: "Statistics"),
                // ),
                // Container(
                //   child: RoundedButton(press: () {}, text: "Control devices"),
                // ),
                // Container(
                //   child: RoundedButton(
                //       press: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) {
                //             return Overview();
                //           }),
                //         );
                //       },
                //       text: "Plant Library"),
                // ),
                // Container(
                //   child: RoundedButton(press: () {}, text: "Chatbox"),
                // ),
                Container(
                  width: size.width * 0.35,
                  height: size.height * 0.2,
                  margin: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                      horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: IconButton(
                    iconSize: size.height * 0.1,
                    icon: SvgPicture.asset('assets/icons/clipboard.svg',
                        color: Colors.white),
                    tooltip: 'Report management',
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: size.width * 0.35,
                  height: size.height * 0.2,
                  margin: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                      horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: IconButton(
                    iconSize: size.height * 0.1,
                    icon: const Icon(Icons.stacked_bar_chart,
                        color: Colors.white),
                    tooltip: 'Statistics',
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: size.width * 0.35,
                  height: size.height * 0.2,
                  margin: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                      horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: IconButton(
                    iconSize: size.height * 0.1,
                    icon: const Icon(Icons.chat_bubble, color: Colors.white),
                    tooltip: 'Chatbox',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
