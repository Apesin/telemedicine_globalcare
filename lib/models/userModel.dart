
class BadgesModel {
  BadgesModel({

  required this.userId, required this.dateCreated, required this.status, required this.badge_id, required this.dateModified, required this.note,
    required this.user_badge_id,
  });
  String user_badge_id;
  String userId;
  String badge_id;
  String note;
  String status;
  String dateCreated;
  String dateModified;

  factory BadgesModel.fromJson(Map<String, dynamic> json) {
    return BadgesModel(
        userId: json['userId'],
        user_badge_id: json['user_badge_id'],
        badge_id: json['badge_id'],
        note :json['note'],
        status: json['status'],
        dateCreated : json['dateCreated'],
        dateModified: json['dateModified'],
        // badgeImage: BadgeImage.fromJson(json['badge'] as Map<String, dynamic>),
    );
  }
}
