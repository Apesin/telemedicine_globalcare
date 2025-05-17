import 'dart:math';

import 'package:doctor_app/bloc/states/labResult.dart';
import 'package:doctor_app/screens/labResult/resultDetails.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/loader.dart';

class LabResult extends StatefulWidget{
  _LabResult createState()=> _LabResult();
  String personId;
  LabResult({required this.personId});
}

class _LabResult extends State<LabResult>{
  bool isLoading = true;
  LabResultState _labResultState = LabResultState();
  List<dynamic> results = [];

  String extractFirstLetters(String sentence) {
    List<String> words = sentence.split(RegExp(r'\s+'));
    String firstLetters = "";

    for (String word in words) {
      if (word.isNotEmpty) {
        firstLetters += word[0];
      }
    }

    return firstLetters;
  }

  @override
  void initState() {
    _labResultState.getLabResult(widget.personId);
    _labResultState.addListener(() {
      setState(() {
        isLoading = false;
        results = _labResultState.results;
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
          body: results.length == 0 ? Center(
            child: Text("No Lab result found"),
          ) : ListView.builder(
              itemCount: results.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  onTap: (){
                    pushPage(context, LabResultDetails(billDetailId: results[index]['bill_detail_id'].toString()));
                  },
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Color(Random().nextInt(0xFFFFFFFF)),
                    child: Center(
                      child: Text("${extractFirstLetters(results[index]['test name'].toString())}"),
                    ),
                  ),
                  title: Text(results[index]['test name']),
                  subtitle: Text("Click to result view details"),
                );
              }),
        ),
        Visibility(
            visible: isLoading,
            child: Loader())
      ],
    );
  }
}