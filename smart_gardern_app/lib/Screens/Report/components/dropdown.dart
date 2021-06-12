import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State<DropDown> {
  String dropdownValue = 'Newest First';
  String holder = '';
  List<String> actorsName = ['Newest First', 'Oldest First'];
  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
    changing(holder);
  }

  void changing(str) {
    ReportNotifier reportNotifier =
        Provider.of<ReportNotifier>(context, listen: false);
    reportNotifier.order = holder;
    getReports(reportNotifier, reportNotifier.reportList,
        reportNotifier.currentsearchValue, reportNotifier.currentorderValue);
  }

  @override
  Widget build(BuildContext context) {
    ReportNotifier reportNotifier =
        Provider.of<ReportNotifier>(context, listen: false);
    dropdownValue = reportNotifier.currentorderValue;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
      child: Row(
        children: [
          Column(children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? data) {
                setState(() {
                  dropdownValue = data!;
                });
                getDropDownItem();
              },
              items: actorsName.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ]),
        ],
      ),
    );
  }
}
