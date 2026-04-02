class NotificationModel {
final int? pageIndex;
  final int? pageSize;
  final int? count;
  final List<NotificationData>? data;

  NotificationModel({
    this.pageIndex,
    this.pageSize,
    this.count,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      pageIndex: json['pageIndex'],
      pageSize: json['pageSize'],
      count: json['count'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => NotificationData.fromJson(i)).toList()
          : null,
    );
  }
}

class NotificationData {
  final String? title;
  final String? content;
  final bool? isRead;
  final String? createdAt;

  NotificationData({
    this.title,
    this.content,
    this.isRead,
    this.createdAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      title: json['title'],
      content: json['content'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
    );
  }
}