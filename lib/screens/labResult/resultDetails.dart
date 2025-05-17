import 'package:doctor_app/bloc/states/labResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/loader.dart';

class LabResultDetails extends StatefulWidget{
  _LabResultDetails createState()=> _LabResultDetails();
  String billDetailId;
  LabResultDetails({required this.billDetailId});
}

class _LabResultDetails extends State<LabResultDetails>{
  bool isLoading = true;
  LabResultState _labResultState = LabResultState();
  Map<dynamic,dynamic> results = {};

  List<Widget> keyValueWidgets = [];
  List<DataRow> dataRows = [];


  @override
  void initState() {
    _labResultState.getLabResultDetails(widget.billDetailId);
    _labResultState.addListener(() {
      setState(() {
        isLoading = false;
        results = _labResultState.labDetails;
      });
      results.forEach((key, value) {
        dataRows.add(DataRow(cells: [
          DataCell(Text("${key.toString().replaceAll("_", " ").toUpperCase()}")),
          DataCell(Text("$value")),
        ]));
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: true,
            title: Text("GlobalCare PSSA", style: TextStyle(
                fontFamily: 'Avenir', color: Colors.white,
                fontSize: 20
            ),),
            actions: [
              PopupMenuButton(
                icon: FaIcon(FontAwesomeIcons.user, size: 20, color: Colors.white,),
                onSelected: (value) {
                  Helpers().logout(context);
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      child: Container(
                        color: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.signOutAlt, size: 20, color: Colors.white,),
                              SizedBox(width: 5,),
                              Text('Sign Out', style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        ),
                      ),
                      value: '/logout',
                    ),
                  ];
                },
              )
            ],
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black), // Add border to the DataTable
                  ),
                  columns: [
                DataColumn(label: Text('TEST')),
                DataColumn(label: Text('RESULT')),
              ], rows: dataRows)
            ),
          )
        ),
        Visibility(
            visible: isLoading,
            child: Loader())
      ],
    );
  }
}