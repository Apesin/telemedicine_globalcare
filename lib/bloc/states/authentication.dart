
import 'package:doctor_app/bloc/methods/authentication.dart';
import 'package:doctor_app/persistence/persistence.dart';
import 'package:doctor_app/persistence/strings.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationState with ChangeNotifier{
  bool isLoading = false;
  String isSignedIn = "notYet";
  String isCreated = "notYet";
  String message = "";

  reset(){
    isSignedIn = "notYet";
    isCreated = "notYet";
    message = "";
    notifyListeners();
  }

  signIn(String email, String password){
    reset();
    Map<dynamic, dynamic> payload = {
      "p_username" : email,
      "p_password" : password
    };
    performAuthenticateUser(payload).then((response){
      print(response.extraData);
      if(response.isSuccessful){
        if(response.extraData['response'] != "failed"){
          isLoading = false;
          isSignedIn = "yes";
          message = response.extraData['reason'];
          completeLogin(response.extraData);
          notifyListeners();
        }else{
          isLoading = false;
          isSignedIn = "no";
          message = response.extraData['reason'];
          notifyListeners();
        }
      }else{
        isLoading = false;
        isSignedIn = "no";
        message = response.extraData['message'] ?? response.errorMessage;
        notifyListeners();
      }
    });
  }

  anonymousLogin(payload,hospitalId){
    reset();
    performUserCardLogin(payload).then((response){
      print(response);
      if(response.isSuccessful){
        if(response.extraData['response'] != "failed" && response.extraData["items"].toString() != '[]'){
          isLoading = false;
          isSignedIn = "yes";
          // message = response.extraData['reason'] ?? "";
          completeAnonymous(response.extraData['items'][0], hospitalId.toString());
          notifyListeners();
        }else{
          isLoading = false;
          isSignedIn = "no";
          message = response.extraData['reason'] ?? "Error creating account, kindly check the provided credentials";
          notifyListeners();
        }
      }else{
        isLoading = false;
        isSignedIn = "no";
        message = response.extraData['message'] ?? response.errorMessage;
        notifyListeners();
      }
    });
  }

  createExistingUser(String nin_no, String first_name, String middle_name,
      String last_name,
      String phone_number, String username, String emrCardNo){
    Map<dynamic,dynamic> payload = {
      "p_nin_no" :     nin_no,
      "p_first_name" : first_name,
      "p_last_name" :  last_name,
      "p_middle_name" : middle_name,
      "p_phone_no"  :  phone_number,
      "p_user_name" :  username
    };
    reset();
    performCreateNewUser(payload).then((response){
      print(response.extraData);
      if(response.isSuccessful){
        if(response.extraData['status'] != "faild" && response.extraData['status'] != "failed"){
          isLoading = false;
          isCreated = "yes";
          notifyListeners();
        }else{
          isLoading = false;
          isCreated = "no";
          message = response.extraData['message'] ?? "Error creating account, kindly check the provided credentials";
          notifyListeners();
        }
      }else{
        isLoading = false;
        isCreated = "no";
        message = response.extraData['message'] ?? response.errorMessage;
        notifyListeners();
      }
    });
  }

  createNewUser(String nin_no, String first_name, String middle_name, String last_name, String sex,
      String phone_number, String username, String dob){
    Map<dynamic,dynamic> payload = {
      "p_nin_no" :     nin_no,
      "p_first_name" : first_name,
      "p_last_name" :  last_name,
      "p_middle_name" : middle_name,
      "p_sex" : sex,
      "p_phone_no"  :  phone_number,
      "p_user_name" :  username,
      "p_date_of_birth" : dob
    };
    reset();
    performCreateNewUser(payload).then((response){
      if(response.isSuccessful){
        if(response.extraData['status'] != "faild" && response.extraData['status'] != "failed"){
          isLoading = false;
          isCreated = "yes";
          notifyListeners();
        }else{
          isLoading = false;
          isCreated = "no";
          message = response.extraData['message'] ?? "Error creating account, kindly check the provided credentials";
          notifyListeners();
        }
      }else{
        isLoading = false;
        isCreated = "no";
        message = response.extraData['message'] ?? response.errorMessage;
        notifyListeners();
      }
    });
  }

  completeAnonymous(response, String hospitalId) async{
    await addStringToSP(PrefStrings.FIRSTNAME, response['first_name'].toString());
    await addStringToSP(PrefStrings.LASTNAME, response['last_name'].toString());
    await addStringToSP(PrefStrings.BRANCH_ID, response['branch_id'].toString());
    await addStringToSP(PrefStrings.HOSPITAL_NAME, response['hospital_name'].toString());
    await addStringToSP(PrefStrings.HOSPITAL_ID, hospitalId);
    await addStringToSP(PrefStrings.SEX, response['sex'].toString());
    await addStringToSP(PrefStrings.DATE_OF_REGISTRATION, response['date_of_registration'].toString());
    await addStringToSP(PrefStrings.CARD_NO, response['card_no'].toString());
    await addStringToSP(PrefStrings.CARD_STATUS, response['card_status'].toString());
    await addStringToSP(PrefStrings.PHONE_NO, response['patient_phone_no'].toString());
    await addStringToSP(PrefStrings.EMAIL, response['e_mail'].toString());
    await addStringToSP(PrefStrings.LOCATION_ID, response['location_id'].toString());
    await addStringToSP(PrefStrings.PERSON_ID, response['person_id'].toString());
    await addStringToSP(PrefStrings.LOGGED_IN, "yes");

  }

  completeLogin(response)async {
    await addStringToSP(PrefStrings.FIRSTNAME, response['firstname'].toString());
    await addStringToSP(PrefStrings.LASTNAME, response['lastname'].toString());
    await addStringToSP(PrefStrings.BRANCH_NAME, response['branch_name'].toString());
    await addStringToSP(PrefStrings.HOSPITAL_NAME, response['hospital_name'].toString());
    await addStringToSP(PrefStrings.OTP, response['OTP'].toString());
    await addStringToSP(PrefStrings.HOSPITAL_ID, response['hospital_id'].toString());
    await addStringToSP(PrefStrings.BRANCH_ID, response['branch_id'].toString());
    await addStringToSP(PrefStrings.USERNAME, response['username'].toString());
    await addStringToSP(PrefStrings.PERSON_ID, response['person_id'].toString());
    await addStringToSP(PrefStrings.LOGGED_IN, "yes");
  }
}