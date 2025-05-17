import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/bloc/states/authentication.dart';
import 'package:doctor_app/bloc/states/hospitals.dart';
import 'package:doctor_app/models/hospitalModel.dart';
import 'package:doctor_app/screens/auth/sign_up_screen.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:doctor_app/widgets/alert.dart';
import 'package:doctor_app/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/sign_up_form.dart';

class SignInScreen extends StatefulWidget {
  _SignInScreen createState()=> _SignInScreen();
}

class _SignInScreen extends State<SignInScreen>{
  final _formKey = GlobalKey<FormState>();
  late String _username, _password, _emrCardNo;
  bool isLoading = false;
  AuthenticationState _authenticationState = AuthenticationState();
  HospitalsState _hospitalsState = HospitalsState();
  // final hospitalCtrl = TextEditingController();
  final branchCtrl = TextEditingController();
  final emrCardCtrl = TextEditingController();

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  List<HospitalModel> h = [];
  List<String> hStrings = ["none"];
  String selectedHospital = "";

  List<BranchModel> b = [];
  List<String> bStrings = ["none"];
  String selectedBranch = "";
  SingleSelectController<String?> hospitalCtrl = SingleSelectController<String?>('');

  Future<List<String>> getRequestData(String query) async {
    List<String> data = hStrings;

    return await Future.delayed(const Duration(seconds: 0), () {
      return data.where((e) {
        return e.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<List<String>> getBranches(String query) async {
    List<String> data = hStrings;

    return await Future.delayed(const Duration(seconds: 0), () {
      return data.where((e) {
        return e.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    _hospitalsState.getHospitals();
    // _hospitalsState.getBranches();
    _authenticationState.addListener(() {
      if(_authenticationState.isSignedIn == "yes"){
        setState(() {
          isLoading = false;
        });
        Alerts().showAlert(context, true, _authenticationState.message);
        Navigator.pushNamed(context, '/home');

      }else if(_authenticationState.isSignedIn == "no"){
        setState(() {
          isLoading = false;
        });
        Alerts().showAlert(context,false, _authenticationState.message);
      }
    });

    _hospitalsState.addListener(() {
      if(_hospitalsState.hospitalsGotten == "yes"){
        setState(() {
          h = _hospitalsState.hospitals;
          hStrings = _hospitalsState.hS;
        });
      }else if(_hospitalsState.hospitalsGotten == "no"){
        setState(() {
          hStrings = ["No hospital"];
        });
      }

      if(_hospitalsState.branchesGotten == "yes"){
        setState(() {
          b = _hospitalsState.branches;
          bStrings = _hospitalsState.bS;
        });
      }else if(_hospitalsState.branchesGotten == "no"){
        setState(() {
          bStrings = ["No Branch"];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: defaultPadding * 2),
                          Center(
                            child: Image.asset('assets/images/logo.png', width: 100,),
                          ),
                          const SizedBox(height: defaultPadding),
                          const Center(child: Text("GlobalCare-TeleMED", style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20
                          ),)),
                          const SizedBox(height: defaultPadding),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: defaultPadding),
                                const TextFieldName(text: "Select Hospital"),
                                hStrings[0] == "none" ? Center(
                                  child: Image.asset("assets/images/spinner.gif", width: 50,),
                                ) :
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey)
                                  ),
                                  child: CustomDropdown.searchRequest(
                                    futureRequest: getRequestData, // Your future request to fetch data
                                    hintText: 'Search hospitals',  // The hint text shown in the dropdown
                                    controller: hospitalCtrl,      // Pass SingleSelectController here
                                    onChanged: (v) {
                                      setState(() {
                                        selectedHospital = v!;      // Update the selected hospital
                                      });
                                    },
                                    futureRequestDelay: const Duration(seconds: 1), // Delay before starting the search
                                  ),

                                ),

                                const SizedBox(height: defaultPadding),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(hintText: "Enter your email"),
                                  validator: emailValidator,
                                  controller: emailCtrl,
                                  onSaved: (cardNo) => _emrCardNo = cardNo!,
                                ),

                                const SizedBox(height: defaultPadding),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(hintText: "Password"),
                                  validator: passwordValidator,
                                  controller: passwordCtrl,
                                  onSaved: (cardNo) => _emrCardNo = cardNo!,
                                ),

                                const SizedBox(height: defaultPadding),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              int index = h.indexWhere((element) => element.hospital_name == selectedHospital);
                              if (_formKey.currentState!.validate()) {
                                if(index != -1){
                                  _authenticationState.signIn(emailCtrl.text, passwordCtrl.text);
                                  _formKey.currentState!.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                }else{
                                  Alerts().showAlert(context, false, "Hospital ID is required");
                                }

                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: primaryColor,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.lock_rounded, color: Colors.white,),
                                  SizedBox(width: 2,),
                                  Text("Sign In", style: TextStyle(
                                      fontFamily: 'Avenir', fontSize: 20, color: Colors.white
                                  ),)
                                ],
                              ),

                            ),
                          ),
                          const SizedBox(height: 6,),
                          InkWell(
                            onTap: (){
                              pushPage(context, const SignUpScreen());
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.lock_rounded, color: Colors.black,),
                                  SizedBox(width: 2,),
                                  Text("Sign Up", style: TextStyle(
                                      fontFamily: 'Avenir', fontSize: 20, color: Colors.black
                                  ),)
                                ],
                              ),

                            ),
                          ),
                          const SizedBox(height: 20,),
                          const Center(
                            child: Text("Reset Password", style: TextStyle(color: primaryColor),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: MediaQuery.of(context).size.height*0.5,)
              ],
            ),
          ),
        ),
        Visibility(
            visible: isLoading,
            child: Loader())
      ],
    );
  }
}
