
class DepartmentModel {
  DepartmentModel({
    required this.clinic_id,
    required this.description,
    required this.clinic_name,
    required this.department_id,
    required this.consultation_fee_id
  });
  String description;
  String clinic_name;
  int clinic_id;
  int consultation_fee_id;
  int department_id;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      description: json['description'] ?? "",
      clinic_name: json['clinic_name'] ?? "",
      clinic_id: json['clinic_id'] ?? 0,
      department_id: json['department_id'] ?? 0,
      consultation_fee_id: json['consultation_fee_id'] ?? 0,
    );
  }
}