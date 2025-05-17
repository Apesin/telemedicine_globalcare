import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/bloc/states/authentication.dart';
import 'package:doctor_app/bloc/states/hospitals.dart';
import 'package:doctor_app/models/hospitalModel.dart';
import 'package:doctor_app/widgets/alert.dart';
import 'package:doctor_app/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/sign_up_form.dart';

class AnonymousLogin extends StatefulWidget {
  _AnonymousLogin createState()=> _AnonymousLogin();
}

class _AnonymousLogin extends State<AnonymousLogin>{
  final _formKey = GlobalKey<FormState>();
  late String _emrCardNo, _password;
  bool isLoading = false;
  AuthenticationState _authenticationState = AuthenticationState();
  HospitalsState _hospitalsState = HospitalsState();
  final hospitalCtrl = TextEditingController();
  final branchCtrl = TextEditingController();

  List<HospitalModel> h = [];
  List<String> hStrings = ["none"];
  String selectedHospital = "";

  List<BranchModel> b = [];
  List<String> bStrings = ["none"];
  String selectedBranch = "";

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

                          Text(
                              "Sign In",
                              style: TextStyle(
                                  color: primaryColor, fontWeight: FontWeight.bold,
                                  fontSize: 50, fontFamily: "Avenir"
                              )
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          Center(
                            child: Image.asset('assets/images/logo.png', width: 100,),
                          ),
                          const SizedBox(height: defaultPadding),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: defaultPadding),
                                TextFieldName(text: "EMR CARD No"),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(hintText: "Enter EMR Card No"),
                                  validator: emrValidator,
                                  onSaved: (emrCardNo) => _emrCardNo = emrCardNo!,
                                ),
                                const SizedBox(height: defaultPadding),
                              ],
                            ),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Sign up form is done
                                  // It saved our inputs
                                  _formKey.currentState!.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  _authenticationState.anonymousLogin(_emrCardNo, "1");
                                  //  Sign in also done
                                }
                              },
                              child: Text("Sign In", style: TextStyle(
                                  fontFamily: 'Avenir', fontSize: 25
                              ),),
                            ),
                          ),
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
