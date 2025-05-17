import 'package:doctor_app/screens/generateToken/generateToken.dart';
import 'package:flutter/material.dart';

import '../screens/appointments/appointments.dart';

import '../screens/appointments/testMeeting.dart';
import '../screens/home/doctor_detail.dart';
import '../screens/home/home.dart';
import '../screens/welcome/welcome_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => WelcomeScreen(),
  // '/': (context) => TestAppointment(),
  '/home': (context) => Home(),
  // '/detail': (context) => SliverDoctorDetail(),
  // '/generateToken': (context) => GenerateToken(),
  '/bookAppointment' : (context) => Appointments(),

};
