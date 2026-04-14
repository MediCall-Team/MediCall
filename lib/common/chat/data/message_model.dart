class MessageModel {
  final int id;
  final int chatId;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime sentAt;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sentAt,
    required this.isRead,
  });

  // تحويل JSON (Map) إلى كائن (Object)
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      sentAt: DateTime.parse(json['sentAt']), // تحويل النص إلى تاريخ
      isRead: json['isRead'],
    );
  }

  // تحويل الكائن (Object) إلى JSON لإرساله للسيرفر
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'sentAt': sentAt.toIso8601String(),
      'isRead': isRead,
    };
  }
}