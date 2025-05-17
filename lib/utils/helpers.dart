import 'package:doctor_app/persistence/persistence.dart';
import 'package:doctor_app/screens/welcome/welcome_screen.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:flutter/cupertino.dart';

import '../persistence/strings.dart';

class Helpers{

  getGreetings<String>(){
    var timeNow = DateTime.now().hour;
    if(timeNow <= 12){
      return "Good Morning";
    }else if(timeNow > 12 && timeNow <= 16){
      return "Good Afternoon";
    }else if(timeNow > 16 && timeNow < 20){
      return "Good Evening";
    }else if(timeNow >= 20 && timeNow <= 24){
      return "Good Night";
    }
  }


  logout(BuildContext context) async{
    await removeValues(PrefStrings.FIRSTNAME);
    await removeValues(PrefStrings.LASTNAME);
    await removeValues(PrefStrings.BRANCH_NAME);
    await removeValues(PrefStrings.HOSPITAL_NAME);
    await removeValues(PrefStrings.OTP);
    await removeValues(PrefStrings.HOSPITAL_ID);
    await removeValues(PrefStrings.BRANCH_ID);
    await removeValues(PrefStrings.USERNAME);
    await removeValues(PrefStrings.LOGGED_IN);
    await removeValues(PrefStrings.PERSON_ID);
    popUntil(context, WelcomeScreen());
  }
}