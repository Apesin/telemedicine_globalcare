import 'dart:developer';

import 'package:doctor_app/bloc/methods/appointment.dart';
import 'package:doctor_app/models/appointmentModel.dart';
import 'package:flutter/cupertino.dart';

class AppointmentState with ChangeNotifier{
  String appointmentFixed = "notYet";
  String message = "";
  String appointmentsGotten = "notYet";

  List<AppointmentModel> get appointments => _appointments;
  List<AppointmentModel> _appointments = [];

  fixAppointment(payload){
    print(payload);
    performFixAppointment(payload).then((response) {
      if(response.isSuccessful){
       if(response.extraData['response'] == "success"){
         appointmentFixed = "yes";
         message = response.extraData['reason'];
         notifyListeners();
       }else{
         appointmentFixed = "no";
         message = response.extraData['reason'];
         notifyListeners();
       }
      }else{
        appointmentFixed = "no";
        message = response.extraData['reason'];
        notifyListeners();
      }
    });
  }


  getFixedAppointments(payload){
    List<AppointmentModel> m = [];
    performGetFixedAppointments(payload).then((response){
      log(response.extraData.toString());
      if(response.isSuccessful){
        if(response.extraData['items'] != []){
        List rawAppointments = response.extraData['items'];
        rawAppointments.forEach((appointment) {
          m.add(AppointmentModel.fromJson(appointment));
        });
        _appointments = m;
        appointmentsGotten = "yes";
        notifyListeners();
        }else{
          _appointments =[];
          appointmentsGotten = "no";
          notifyListeners();
        }
      }else{
      _appointments = [];
      appointmentsGotten = "no";
      notifyListeners();
      }
    });
  }
}