import 'package:doctor_app/bloc/methods/hospitals.dart';
import 'package:doctor_app/models/departmentModel.dart';
import 'package:doctor_app/models/doctorsModel.dart';
import 'package:doctor_app/models/hospitalModel.dart';
import 'package:flutter/cupertino.dart';

class HospitalsState with ChangeNotifier{
  bool isLoading = false;
  String hospitalsGotten = "notYet";
  String branchesGotten = "notYet";
  String clinicsGotten = "notYet";
  String doctorsGotten = "notYet";

  String message = "";
  List<HospitalModel> _hospitals = [];
  List<HospitalModel> get hospitals => _hospitals;
  List<String> _hS = [];
  List<String> get hS => _hS;

  List<BranchModel> _branches = [];
  List<BranchModel> get branches => _branches;
  List<String> _bS = [];
  List<String> get bS => _bS;

  List<DepartmentModel> _clinics = [];
  List<DepartmentModel> get clinics => _clinics;
  List<String> _cS = [];
  List<String> get cS => _cS;

  List<DoctorsModel> _doctors = [];
  List<DoctorsModel> get doctors => _doctors;
  List<String> _dS = [];
  List<String> get dS => _dS;

  getHospitals(){
    List<HospitalModel> _h = [];
    List<String> _hString = [];
    performGetHospitals().then((response){
      if(response.isSuccessful){
        hospitalsGotten = "yes";
        List rawHospitals = response.extraData['items'];
        rawHospitals.forEach((eachH) {
          _h.add(HospitalModel.fromJson(eachH));
          _hString.add(HospitalModel.fromJson(eachH).hospital_name);
        });
        _hospitals = _h;
        _hS = _hString;
        notifyListeners();
      }else{
        hospitalsGotten = "no";
        notifyListeners();
      }
    });
  }

  getBranches(){
    List<BranchModel> _b = [];
    List<String> _bString = [];
    performGetBranches().then((response){
      if(response.isSuccessful){
        branchesGotten = "yes";
        List rawHospitals = response.extraData['items'];
        rawHospitals.forEach((eachB) {
          _b.add(BranchModel.fromJson(eachB));
          _bString.add(BranchModel.fromJson(eachB).branch_name);
        });
        _branches = _b;
        _bS = _bString;
        notifyListeners();
      }else{
        branchesGotten = "no";
        notifyListeners();
      }
    });
  }

  getClinics(String hospital,String branch){
    print(hospital);
    print(branch);
    List<DepartmentModel> _c = [];
    List<String> _cString = [];
    performGetClinics(hospital,branch).then((response){
      if(response.isSuccessful){
        clinicsGotten = "yes";
        List rawHospitals = response.extraData['items'];
        rawHospitals.forEach((eachB) {
          _c.add(DepartmentModel.fromJson(eachB));
          _cString.add(DepartmentModel.fromJson(eachB).clinic_name);
        });
        _clinics = _c;
        _cS = _cString;
        notifyListeners();
      }else{
        clinicsGotten = "no";
        notifyListeners();
      }
    });
  }

  getDoctors(String hospital, String branch, String clinicId ){
    List<DoctorsModel> _d = [];
    List<String> _dString = [];

    performGetDoctors(hospital,branch,clinicId).then((response){
      if(response.isSuccessful){
        doctorsGotten = "yes";
        List rawHospitals = response.extraData['items'];
        rawHospitals.forEach((eachD) {
          _d.add(DoctorsModel.fromJson(eachD));
          _dString.add("${DoctorsModel.fromJson(eachD).first_name} ${DoctorsModel.fromJson(eachD).last_name}" );
        });
        _doctors = _d;
        _dS = _dString;
        notifyListeners();
      }else{
        doctorsGotten = "no";
        notifyListeners();
      }
    });
  }




  Future<List<HospitalModel>> fetchHospitals() async {
    final response = await performGetHospitals();
    final data = response.extraData['items'] as List<dynamic>;
    return data.map((json) => HospitalModel.fromJson(json)).toList();
  }

}