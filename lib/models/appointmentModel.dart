
class AppointmentModel {
  AppointmentModel({

    required this.appointment_id,
    required this.doctor_id,
    required this.doctor_name,
    required this.admission_id,
    required this.appointment_date,
    required this.appointment_time,
    required this.appointment_type,
    required this.booking_date,
    required this.booking_location,
    required this.branch_id,
    required this.branch_name,
     required this.clinic_id,
    required this.clinic_name,
    required this.created_by,
    required this.desciption,
    required this.hospital_id,
    required this.hospital_name,
    required this.person_id,
    required this.status,
    required this.zoom_meeting_url
  });
  int appointment_id;
  int doctor_id;
  String doctor_name;
  String desciption;
  String appointment_date;
  String status;
  String appointment_time;
  int clinic_id;
  String clinic_name;
  int admission_id;
  int person_id;
  int hospital_id;
  String hospital_name;
  int branch_id;
  String branch_name;
  String booking_date;
  String booking_location;
  int created_by;
  String appointment_type;
  String zoom_meeting_url;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointment_id: json['appointment_id'],
      doctor_id: json['doctor_id'] ?? 0,
      doctor_name: json['doctor_name'] ?? "",
        desciption: json['desciption'] ?? "",
     appointment_date: json['appointment_date'] ?? "",
     status: json['status'] ?? "",
     appointment_time: json['appointment_time'] ?? "",
     clinic_id: json['clinic_id'] ?? 0,
     clinic_name: json['clinic_name'] ?? "",
     admission_id: json['admission_id'] ?? 0,
     person_id : json['person_id'] ?? 0,
     hospital_id: json['hospital_id'] != null ? int.parse(json['hospital_id'].toString()) : 0,
     hospital_name: json['hospital_name'] ?? "",
     branch_id: json['branch_id'] ?? 0,
     branch_name: json['branch_name'] ?? "",
     booking_date: json['booking_date'] ?? "",
     booking_location: json['booking_location'] ?? "",
     created_by: json['created_by'] ?? 0,
     appointment_type: json['appointment_type'] ?? "",
        zoom_meeting_url: json['zoom_meeting_url'] ?? ""
    );
  }
}
