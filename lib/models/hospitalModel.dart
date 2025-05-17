
class HospitalModel {
  HospitalModel({

    required this.hospital_id,
    required this.hospital_name,
    required this.baseUrl,
  });
  int hospital_id;
  String hospital_name;
  String baseUrl;

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      hospital_id: json['hospital_id'],
      hospital_name: json['hospital_name'],
      baseUrl: json['baseUrl'] ?? "",
      // badgeImage: BadgeImage.fromJson(json['badge'] as Map<String, dynamic>),
    );
  }
}


class BranchModel {
  BranchModel({

    required this.branch_id,
    required this.branch_name,
    required this.branch_code,
  });
  int branch_id;
  String branch_name;
  String branch_code;

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      branch_id: json['branch_id'],
      branch_name: json['branch_name'],
      branch_code: json['branch_code'] ?? "",
      // badgeImage: BadgeImage.fromJson(json['badge'] as Map<String, dynamic>),
    );
  }
}