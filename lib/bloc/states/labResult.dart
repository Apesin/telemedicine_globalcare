import 'package:doctor_app/bloc/methods/labResultMethod.dart';
import 'package:flutter/cupertino.dart';

class LabResultState with ChangeNotifier{
  String labResultGotten = "notYet";
  List<dynamic> results = [];
  List<dynamic> radiologyResult = [];
  Map<dynamic,dynamic> labDetails = {};

  getLabResult(payload){
    performGetLabResult(payload).then((response){
      if(response.isSuccessful){
      List<dynamic> data = response.extraData['items'];
      results = data;
      notifyListeners();
      }else{
        notifyListeners();
      }
    });
  }

  getLabResultDetails(payload){
    performGetLabResultDetails(payload).then((response){
      if(response.isSuccessful){
       if(response.extraData['items'].toString() != "[]"){
         Map<dynamic, dynamic> data = response.extraData['items'][0];
         labDetails = data;
         notifyListeners();
       }else{
         notifyListeners();
       }
      }else{
        labDetails = {};
        notifyListeners();
      }
    });
  }

  getRadiologyResult(payload){
    performGetRadiologyResult(payload).then((response){
      if(response.isSuccessful){
        List<dynamic> data = response.extraData['items'];
        radiologyResult = data;
        notifyListeners();
      }else{
        notifyListeners();
      }
    });
  }

}