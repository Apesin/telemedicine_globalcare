import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/bloc/states/appointment.dart';
import 'package:doctor_app/constants.dart';
import 'package:doctor_app/models/departmentModel.dart';
import 'package:doctor_app/models/doctorsModel.dart';
import 'package:doctor_app/persistence/persistence.dart';
import 'package:doctor_app/persistence/strings.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:doctor_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../bloc/states/hospitals.dart';
import '../../models/hospitalModel.dart';
import '../../utils/helpers.dart';
import '../../widgets/alert.dart';
import '../auth/components/sign_up_form.dart';

class Appointments extends StatefulWidget{
  const Appointments({super.key});

  _Appointments createState ()=> _Appointments();
}

class _Appointments extends State<Appointments>{
  final _formKey = GlobalKey<FormState>();
  HospitalsState _hospitalsState = HospitalsState();
  AppointmentState _appointmentState = AppointmentState();
  final hospitalCtrl = TextEditingController();
  final branchCtrl = TextEditingController();
  // final clinicCtrl = TextEditingController();
  // final doctorCtrl = TextEditingController();

  List<HospitalModel> h = [];
  List<String> hStrings = ["none"];
  String selectedHospital = "";

  List<BranchModel> b = [];
  List<String> bStrings = ["none"];
  String selectedBranch = "";

  List<DepartmentModel> c = [];
  List<String> cStrings = ["none"];
  String selectedClinic = "";

  List<DoctorsModel> d = [];
  List<String> dStrings = ["none"];
  String selectedDoctors = "";

  bool isLoading = false;
  String hospitalName = "";
  String branchName = "";
  String patientName = "";
  String _description = "";
  String hospitalId = "";
  String branchId ="";
  String clinicId = "";
  String personId = "";
  String doctorId = "";
  DateTime selected = DateTime.now();
  DateTime initial = DateTime.now();
  DateTime last = DateTime(DateTime.now().year+5);
  TimeOfDay timeOfDay = TimeOfDay.now();
  final _dateC = TextEditingController();
  final _timeC = TextEditingController();

  SingleSelectController<String?> clinicCtrl = SingleSelectController<String?>('');
  SingleSelectController<String?> doctorCtrl = SingleSelectController<String?>('');


  String appointmentDate = "Choose appointment date and time";
  String appointmentTime = "";
  String appointmentType = "";


  void _handleGenderChange(String? value) {
    setState(() {
      appointmentType = value!;
    });
  }

  _appoint(){
    if(branchName != null && hospitalName != null && appointmentDate != "Choose appointment date and time" && _description != ""
    && appointmentType != ""){
      _appointmentState.fixAppointment({
        "appointment_time" : appointmentTime,
        "appointment_type" : appointmentType,
        "description" : _description,
        "doctor_id" : doctorId,
        "person_id" : personId,
        "clinic_id" : selectedClinic,
        "hospital_id" : hospitalId,
        "branch_id" : branchId,
        "appointment_date" : appointmentDate
      });
    }else{
      Alerts().showAlert(context, false, "All fields are required");
    }
  }


  Future displayDatePicker(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      type: OmniDateTimePickerType.dateAndTime,
      primaryColor: primaryColor,
      backgroundColor: Colors.black87,
      calendarTextColor: Colors.white,
      tabTextColor: Colors.white,
      unselectedTabBackgroundColor: Colors.grey[700],
      buttonTextColor: Colors.white,
      timeSpinnerTextStyle:
      const TextStyle(color: Colors.white70, fontSize: 18),
      timeSpinnerHighlightedTextStyle:
      const TextStyle(color: Colors.white, fontSize: 24),
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: DateTime.now(),
      startFirstDate:
      DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      borderRadius: const Radius.circular(16),
    );
    final d = dateTime;
    final formatter = DateFormat('MM-dd-yyyy');
    final timeFormatter = DateFormat('hh:mma');
    final formattedDate = formatter.format(d!);
    final formattedTime = timeFormatter.format(d);
    print(formattedTime);
    setState(() {
      appointmentDate = formattedDate.toString();
      appointmentTime = formattedTime.toString();
    });
  }


  getDetails() async{
    var h = await getStringValuesSP(PrefStrings.HOSPITAL_NAME);
    var b = await getStringValuesSP(PrefStrings.BRANCH_NAME);
    var p = await getStringValuesSP(PrefStrings.FIRSTNAME);
    var hId = await getStringValuesSP(PrefStrings.HOSPITAL_ID);
    var bId = await getStringValuesSP(PrefStrings.BRANCH_ID);
    var pId = await getStringValuesSP(PrefStrings.PERSON_ID);

    setState(() {
      hospitalName = h ?? "";
      branchName = b ?? "";
      patientName = p ?? "";
      branchId = bId ?? "";
      hospitalId = hId ?? "";
      personId = pId ?? "";
    });

    _hospitalsState.getClinics(hospitalId,branchId);
  }

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

  Future<List<String>> getClinics(String query) async {
    List<String> data = cStrings;

    return await Future.delayed(const Duration(seconds: 0), () {
      return data.where((e) {
        return e.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<List<String>> getDoctors(String query) async {
    List<String> data = cStrings;

    return await Future.delayed(const Duration(seconds: 0), () {
      return data.where((e) {
        return e.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }


  @override
  void initState() {
    getDetails();
    // _hospitalsState.getHospitals();
    // _hospitalsState.getBranches();
    _hospitalsState.addListener(() {
      if (_hospitalsState.hospitalsGotten == "yes") {
        setState(() {
          h = List<HospitalModel>.from(_hospitalsState.hospitals ?? []);
          hStrings = _hospitalsState.hS ?? [];  // Default to empty list if null
        });
      } else if (_hospitalsState.hospitalsGotten == "no") {
        setState(() {
          hStrings = ["No hospital"];
        });
      }


      if (_hospitalsState.branchesGotten == "yes") {
        setState(() {
          b = List<BranchModel>.from(_hospitalsState.branches);  // Ensure proper type conversion
          bStrings = _hospitalsState.bS;
        });
      } else if (_hospitalsState.branchesGotten == "no") {
        setState(() {
          bStrings = ["No Branch"];
        });
      }


      if(_hospitalsState.clinicsGotten == "yes"){
        setState(() {
          c = _hospitalsState.clinics;
          cStrings = _hospitalsState.cS;
        });
      }else if(_hospitalsState.clinicsGotten == "no"){
        setState(() {
          cStrings = ["No Branch"];
        });
      }

      if(_hospitalsState.doctorsGotten == "yes"){
        setState(() {
          d = _hospitalsState.doctors;
          dStrings = _hospitalsState.dS;
        });
      }else if(_hospitalsState.doctorsGotten == "no"){
        setState(() {
          dStrings = ["No Branch"];
        });
      }

    });

    _appointmentState.addListener(() {
      if(_appointmentState.appointmentFixed == "yes"){
        setState(() {
          isLoading = false;
        });
        Alerts().showAlert(context, true, _appointmentState.message);
      }else if(_appointmentState.appointmentFixed == "no"){
        setState(() {
          isLoading = false;
        });
        Alerts().showAlert(context, false, _appointmentState.message);
      }
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
          body: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultPadding),
                    Text('Book Appointment', style: TextStyle(
                      fontFamily: 'Avenir', fontSize: 30, fontWeight: FontWeight.bold
                    ),),
                    // const SizedBox(height: defaultPadding),
                    // TextFieldName(text: "Hospital"),
                    // hStrings[0] == "none" ? Center(
                    //   child: Image.asset("assets/images/spinner.gif", width: 50,),
                    // ) :
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       border: Border.all(color: Colors.grey)
                    //   ),
                    //   child: CustomDropdown.searchRequest(
                    //     futureRequest: getRequestData,
                    //     hintText: 'Search hospitals',
                    //     controller: hospitalCtrl,
                    //     onChanged: (v){
                    //       setState(() {
                    //         selectedHospital= v;
                    //       });
                    //     },
                    //     futureRequestDelay: const Duration(seconds: 1),//it waits 3 seconds before start searching (before execute the 'futureRequest' function)
                    //   ),
                    // ),
                    // Visibility(
                    //   visible: true,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const SizedBox(height: defaultPadding),
                    //       TextFieldName(text: "Branches"),
                    //       Container(
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             border: Border.all(color: Colors.grey)
                    //         ),
                    //         child: CustomDropdown.searchRequest(
                    //           futureRequest: getBranches,
                    //           items: bStrings,
                    //           hintText: 'Search branches',
                    //           controller: branchCtrl,
                    //           futureRequestDelay: const Duration(seconds: 3),//it waits 3 seconds before start searching (before execute the 'futureRequest' function)
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Visibility(
                      visible: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: defaultPadding),
                          TextFieldName(text: "Clinic"),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: CustomDropdown.searchRequest(
                              futureRequest: getBranches,
                              items: cStrings,
                              hintText: 'Search clinics',
                              controller: clinicCtrl,  // Use SingleSelectController<String?> here
                              onChanged: (v) {
                                print(v);
                                int x = c.indexWhere((element) => element.clinic_name == v);
                                print(c[x].clinic_id);
                                setState(() {
                                  selectedClinic = c[x].clinic_id.toString();
                                });
                                _hospitalsState.getDoctors(hospitalId, branchId, selectedClinic);
                              },
                              futureRequestDelay: const Duration(seconds: 3), // Waits 3 seconds before starting the search
                            ),
                            // child: CustomDropdown.searchRequest(
                            //   futureRequest: getBranches,
                            //   items: cStrings,
                            //   hintText: 'Search clinics',
                            //   controller: clinicCtrl,
                            //   onChanged: (v){
                            //     print(v);
                            //     int x = c.indexWhere((element) => element.clinic_name == v);
                            //     print(c[x].clinic_id);
                            //     setState(() {
                            //       selectedClinic = c[x].clinic_id.toString();
                            //     });
                            //     _hospitalsState.getDoctors(hospitalId,branchId,selectedClinic);
                            //   },
                            //   futureRequestDelay: const Duration(seconds: 3),//it waits 3 seconds before start searching (before execute the 'futureRequest' function)
                            // ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: defaultPadding),
                          TextFieldName(text: "Doctor"),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: CustomDropdown.searchRequest(
                              futureRequest: getBranches, // Make sure this is a function returning a Future
                              items: dStrings,  // dStrings should be a List<String> or appropriate data for display
                              hintText: 'Search doctors',
                              controller: doctorCtrl,  // Use SingleSelectController<String?> here
                              onChanged: (v) {
                                int x = d.indexWhere((element) => "${element.first_name} ${element.last_name}" == v);
                                print(x);
                                setState(() {
                                  doctorId = d[x].user_id.toString();
                                });
                              },
                              futureRequestDelay: const Duration(seconds: 3), // Waits 3 seconds before starting the search
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextFieldName(text: "Description"),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(hintText: "Enter your description"),
                      validator: descriptionValidator,
                      scrollPadding: EdgeInsets.all(10),
                      onSaved: (description) => _description = description!,
                    ),
                    const SizedBox(height: defaultPadding),
                    TextFieldName(text: "Appointment Date"),
                    InkWell(
                      onTap: (){
                        displayDatePicker(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.withOpacity(0.3))
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(appointmentDate),
                              Container(
                              width: 50,
                                height: 50,
                                color: Colors.blueGrey.withOpacity(0.2),
                                child: Center(
                                  child: FaIcon(FontAwesomeIcons.calendarCheck, color: Colors.grey.withOpacity(0.9),),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                    const SizedBox(height: defaultPadding),
                    TextFieldName(text: "Consultation Type"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Radio(value: 'hospital', groupValue: appointmentType, onChanged: _handleGenderChange),
                              Text("Hospital",style: TextStyle(fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          SizedBox(width: 5,),
                          Row(
                            children: [
                              Radio(value: 'telemedicine', groupValue: appointmentType, onChanged: _handleGenderChange),
                              Text("Telemedicine", style: TextStyle(fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold),)
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: defaultPadding,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         InkWell(
                           onTap: (){
                             popPage(context);
                           },
                           child: Container(
                             width: 100,
                             height: 40,
                             decoration: BoxDecoration(
                               color: Colors.amber,
                               borderRadius: BorderRadius.circular(5)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                 children: [
                                   FaIcon(FontAwesomeIcons.cancel, size: 20,),
                                   SizedBox(width: 10,),
                                   Text("Cancel", style: TextStyle(fontFamily: "Avenir", fontSize: 18, fontWeight: FontWeight.bold),),
                                 ],
                               ),
                             ),
                           ),
                         ),
                          InkWell(
                            onTap: (){
                              if (_formKey.currentState!.validate()) {
                                // Sign up form is done
                                // It saved our inputs
                                _formKey.currentState!.save();
                                setState(() {
                                  isLoading = true;
                                });
                                _appoint();
                                //  Sign in also done
                              }

                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.save,size: 20,),
                                    SizedBox(width: 10,),
                                    Text("Save", style: TextStyle(fontFamily: "Avenir", fontSize: 18, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
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