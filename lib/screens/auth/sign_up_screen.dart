import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/bloc/states/authentication.dart';
import 'package:doctor_app/bloc/states/hospitals.dart';
import 'package:doctor_app/models/hospitalModel.dart';
import 'package:doctor_app/screens/auth/sign_in_screen.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/widgets/alert.dart';
import 'package:doctor_app/widgets/loader.dart';
import '../../constants.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _newFormKey = GlobalKey<FormState>();
  final _existingFormKey = GlobalKey<FormState>();

  final TextEditingController ninController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController existingNinController = TextEditingController();
  final TextEditingController existingPhoneController = TextEditingController();
  final TextEditingController existingFirstnameController = TextEditingController();
  final TextEditingController existingLastnameController = TextEditingController();
  final TextEditingController existingMiddlenameController = TextEditingController();
  final TextEditingController existingUsernameController = TextEditingController();
  final TextEditingController existingEmrController = TextEditingController();

  AuthenticationState _authenticationState = AuthenticationState();
  HospitalsState _hospitalsState = HospitalsState();

  bool isLoading = false;
  DateTime? _selectedDate;
  String? _selectedGender;

  List<HospitalModel> h = [];
  List<String> hStrings = ["none"];
  String selectedHospital = "";
  SingleSelectController<String?> hospitalCtrl = SingleSelectController<String?>('');

  Future<List<String>> getRequestData(String query) async {
    List<String> data = hStrings;

    return await Future.delayed(const Duration(seconds: 0), () {
      return data.where((e) {
        return e.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    _hospitalsState.getHospitals();

    _tabController = TabController(length: 2, vsync: this);
    _authenticationState.addListener(() {
      if(_authenticationState.isCreated == "yes"){
        setState(() {
          isLoading = false;
        });
        Alerts().showAlert(context, true, _authenticationState.message);
        pushPageAsReplacement(context, SignInScreen());
      }else if(_authenticationState.isCreated == "no"){
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
    });
    super.initState();
  }

  Widget _buildTextInput(String label, TextEditingController controller, {bool required = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      TextFormField(
      controller: controller,
      validator: required
          ? (val) => val == null || val.isEmpty ? 'Required field' : null
          : null,
      decoration: InputDecoration(hintText: "Enter $label", hintStyle: TextStyle(fontSize: 14)),),
        const SizedBox(height: defaultPadding),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: defaultPadding * 8),
                Center(
                  child: Image.asset('assets/images/logo.png', width: 100,),
                ),
                const SizedBox(height: defaultPadding),
                const Center(child: Text("Sign Up", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20
                ),)),
                const SizedBox(height: defaultPadding),
                TabBar(
                  controller: _tabController,
                  indicatorColor: primaryColor,
                  labelColor: Colors.black,
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 18
                  ),
                  labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "Existing Patient"),
                    Tab(text: "New Patient"),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height+(300),
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Form(
                          key: _existingFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                    futureRequest: getRequestData,
                                    hintText: 'Search hospitals',
                                    controller: hospitalCtrl,
                                    onChanged: (v) {
                                      setState(() {
                                        selectedHospital = v!;
                                      });
                                    },
                                    futureRequestDelay: const Duration(seconds: 1),
                                  ),
                                ),

                                _buildTextInput("NIN No", existingNinController),

                                // Date of Birth Picker
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () => _selectDate(context),
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                            hintText: "Select date of birth",
                                            hintStyle: TextStyle(fontSize: 14)),
                                        child: Text(
                                          _selectedDate == null
                                              ? 'Select date'
                                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: defaultPadding),
                                  ],
                                ),

                                _buildTextInput("Last 4 digits of the EMR Card number", existingEmrController),
                                _buildTextInput("your email address", existingUsernameController),
                                _buildTextInput("Phone Number", existingPhoneController),
                                const SizedBox(height: defaultPadding * 2),

                                InkWell(
                                  onTap: (){
                                    if (_existingFormKey.currentState!.validate()) {
                                      setState(() => isLoading = true);
                                      _authenticationState.createExistingUser(existingNinController.text,
                                          existingFirstnameController.text,existingMiddlenameController.text,
                                          existingLastnameController.text,
                                          existingPhoneController.text, existingUsernameController.text,
                                          existingEmrController.text);
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
                                        Text("Sign Up", style: TextStyle(
                                            fontFamily: 'Avenir', fontSize: 20, color: Colors.white
                                        ),)
                                      ],
                                    ),

                                  ),
                                ),
                                const SizedBox(height: 6,),
                                InkWell(
                                  onTap: (){
                                    pushPage(context, SignInScreen());
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey.shade300)
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_back, color: Colors.black,),
                                        SizedBox(width: 2,),
                                        Text("Back", style: TextStyle(
                                            fontFamily: 'Avenir', fontSize: 20, color: Colors.black
                                        ),)
                                      ],
                                    ),

                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      // New User Form
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Form(
                          key: _newFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    futureRequest: getRequestData,
                                    hintText: 'Search hospitals',
                                    controller: hospitalCtrl,
                                    onChanged: (v) {
                                      setState(() {
                                        selectedHospital = v!;
                                      });
                                    },
                                    futureRequestDelay: const Duration(seconds: 1),
                                  ),
                                ),

                                _buildTextInput("NIN No", ninController),

                                // Date of Birth Picker
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Date of Birth", style: TextStyle(fontWeight: FontWeight.bold)),
                                    InkWell(
                                      onTap: () => _selectDate(context),
                                      child: InputDecorator(
                                        decoration: const InputDecoration(
                                            hintText: "Select date of birth",
                                            hintStyle: TextStyle(fontSize: 14)),
                                        child: Text(
                                          _selectedDate == null
                                              ? 'Select date'
                                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: defaultPadding),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 30,
                                    decoration:  BoxDecoration(
                                      color: Colors.blue.shade200,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.search, color: Colors.black,),
                                        SizedBox(width: 2,),
                                        Text("Verify NIN", style: TextStyle(
                                            fontFamily: 'Avenir', fontSize: 14, color: Colors.black
                                        ),)
                                      ],
                                    ),

                                  ),
                                ),
                                SizedBox(height: 10,),
                                _buildTextInput("First Name", fnameController),
                                _buildTextInput("Middle Name", mnameController),
                                _buildTextInput("Last Name", lnameController),

                                // Gender Radio Buttons
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Sex", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: "Male",
                                          groupValue: _selectedGender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedGender = value;
                                            });
                                          },
                                        ),
                                        const Text("Male"),
                                        Radio<String>(
                                          value: "Female",
                                          groupValue: _selectedGender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedGender = value;
                                            });
                                          },
                                        ),
                                        const Text("Female"),
                                      ],
                                    ),
                                    const SizedBox(height: defaultPadding),
                                  ],
                                ),
                                _buildTextInput("your email address", usernameController),
                                _buildTextInput("Phone Number", phoneController),

                                const SizedBox(height: defaultPadding * 2),

                                InkWell(
                                  onTap: (){
                                    if (_newFormKey.currentState!.validate()) {
                                      if (_selectedGender == null) {
                                        Alerts().showAlert(context, false, "Please select gender");
                                        return;
                                      }

                                      if (_selectedDate == null) {
                                        Alerts().showAlert(context, false, "Please select date of birth");
                                        return;
                                      }

                                      setState(() => isLoading = true);
                                      _authenticationState.createNewUser(
                                        ninController.text,
                                        fnameController.text,
                                        mnameController.text,
                                        lnameController.text,
                                        _selectedGender!,
                                        phoneController.text,
                                        usernameController.text,
                                        '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                      );
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
                                        Text("Sign Up", style: TextStyle(
                                            fontFamily: 'Avenir', fontSize: 20, color: Colors.white
                                        ),)
                                      ],
                                    ),

                                  ),
                                ),
                                SizedBox(height: 6,),
                                InkWell(
                                  onTap: (){
                                    pushPage(context, SignInScreen());
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey.shade300)
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_back, color: Colors.black,),
                                        SizedBox(width: 2,),
                                        Text("Back", style: TextStyle(
                                            fontFamily: 'Avenir', fontSize: 20, color: Colors.black
                                        ),)
                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (isLoading)  Loader(),
      ],
    );
  }
}