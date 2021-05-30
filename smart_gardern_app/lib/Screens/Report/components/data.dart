import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:smart_gardern_app/Screens/Report/components/report.dart';
import 'package:provider/provider.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  void initState() {
    ReportNotifier reportNotifier =
        Provider.of<ReportNotifier>(context, listen: false);
    getReports(reportNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReportNotifier reportNotifier = Provider.of<ReportNotifier>(context);
    Future<void> _refreshList() async {
      getReports(reportNotifier);
    }

    ScrollController _scrollController = new ScrollController();
    return new RefreshIndicator(
      child: ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          // print(reportNotifier.currentReport.);
          return Reports(
              name: reportNotifier.reportList[index].name.toString(),
              device: reportNotifier.reportList[index].device.toString(),
              date: reportNotifier.reportList[index].date.toString(),
              detail: reportNotifier.reportList[index].detail,
              rid: reportNotifier.reportList[index].rid);
        },
        itemCount: reportNotifier.reportList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
      ),
      onRefresh: _refreshList,
    );
  }
}
// List<Widget> makeListWidget(AsyncSnapshot snapshot) {
//   return snapshot.data.docs.map<Widget>((document) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Reports(
//             name: document["name"].toString(),
//             device: document["device"].toString(),
//             date: document["date"].toString(),
//             detail: document["detail"])
//       ],
//     );
//   }).toList();
// }

// deleteWidget(AsyncSnapshot snapshot, rid, uid) {
//   final alldocs = snapshot.data!.doc;
//   for (var i in alldocs) {
//     if (i.id == rid) {
//       FirebaseFirestore.instance
//           .collection('User')
//           .doc(uid.toString())
//           .collection('Report')
//           .doc(rid.toString())
//           .delete();
//     }
//   }
// }

// ScrollController _scrollController = new ScrollController();
// @override
// Widget build(BuildContext context) {
//   var user = FirebaseAuth.instance.currentUser;
//   var uid;

//   if (user != null) {
//     uid = user.uid;
//   }

//   final ins = FirebaseFirestore.instance
//       .collection('User')
//       .doc(uid.toString())
//       .collection("Report");
//   return Container(
//     child: StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('User')
//           .doc(uid.toString())
//           .collection("Report")
//           .snapshots(),
//       builder: (context, snapshot) {
//         final List<Widget> reportlist;
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return CircularProgressIndicator();
//           default:
//             // final allDocs = snapshot.data!.docs;
//             // for (var i in allDocs) {
//             //   var temp = i.data()!;
//             //   print(i.id);
//             // }
//             reportlist = makeListWidget(snapshot);
//             return ListView(
//               controller: _scrollController,
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               children: reportlist,
//             );
//         }
//       },
//     ),
//   );
// }
