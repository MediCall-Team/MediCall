class ChatModelById {
  final int chatId;
  final int otherPersonId;
  final String otherPersonName;
  final String? otherPersonImage; // جعلته قابل للإلغاء في حال لم تتوفر صورة
  final bool isClosed;

  ChatModelById({
    required this.chatId,
    required this.otherPersonId,
    required this.otherPersonName,
    this.otherPersonImage,
    required this.isClosed,
  });

  // تحويل من JSON إلى Object
  factory ChatModelById.fromJson(Map<String, dynamic> json) {
    return ChatModelById(
      chatId: json['chatId'] ?? 0,
      otherPersonId: json['otherPersonId'] ?? 0,
      otherPersonName: json['otherPersonName'] ?? '',
      otherPersonImage: json['otherPersonImage'],
      isClosed: json['isClosed'] ?? false,
    );
  }

  // تحويل من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'otherPersonId': otherPersonId,
      'otherPersonName': otherPersonName,
      'otherPersonImage': otherPersonImage,
      'isClosed': isClosed,
    };
  }
}