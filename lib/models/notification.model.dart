class NotificationModel {
  String title;
  String message;
  bool read;

  NotificationModel({this.title, this.message, this.read});

  factory NotificationModel.fromMap(Map data) {
    return NotificationModel(
        title: data['title'] ?? '',
        message: data['message'] ?? '',
        read: data['read'] ?? false);
  }

  Map<String, dynamic> toMap() =>
      {'title': title, 'message': message, 'read': read};
}
