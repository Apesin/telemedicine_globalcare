
class DoctorsModel {
  DoctorsModel({
    required this.pwd,
    required this.first_name,
    required this.user_name,
    required this.last_name,
    required this.created_date,
    required this.user_id
  });
  String pwd;
  String first_name;
  String last_name;
  String user_name;
  String created_date;
  int user_id;

  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      pwd: json['pwd'] ?? "",
      first_name: json['first_name'] ?? "",
      last_name: json['last_name'] ?? "",
      user_name: json['user_name'] ?? "",
      created_date: json['created_date'] ?? "",
        user_id: json['user_id'] ?? 0
    );
  }
}