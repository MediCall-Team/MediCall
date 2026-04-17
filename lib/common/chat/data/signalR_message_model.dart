class SignalrMessageModel {
  final int id;
  final int chatId;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime sentAt;
  final bool isRead;
  final bool isPending;

  SignalrMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sentAt,
    required this.isRead,
    this.isPending = false,
  });

  factory SignalrMessageModel.fromJson(Map<String, dynamic> json) {
    // ميثود ذكية جداً: بتحول كل الـ Keys لـ lowercase وبتبحث فيها
    // كدة لو جالك "ChatId" أو "chatid" أو "chatID" هتمسكها
    T? readValue<T>(String key) {
      final lowercaseKey = key.toLowerCase();
      for (var entry in json.entries) {
        if (entry.key.toLowerCase() == lowercaseKey) {
          return entry.value as T?;
        }
      }
      return null;
    }

    return SignalrMessageModel(
      id: readValue<int>('id') ?? 0,
      chatId: readValue<int>('chatId') ?? 0,
      senderId: readValue<int>('userId') ?? 0,
      receiverId: readValue<int>('receiverId') ?? 0,
      content: readValue<String>('content') ?? "",
      sentAt: readValue<String>('sentAt') != null 
          ? DateTime.parse(readValue<String>('sentAt')!) 
          : DateTime.now(),
      isRead: readValue<bool>('isRead') ?? false,
      isPending: false,
    );
  }

  // ميثود toJson يفضل تخليها بالاتفاق مع الباك إند (غالباً camelCase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'userId': senderId,
      'receiverId': receiverId,
      'content': content,
      'sentAt': sentAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  SignalrMessageModel copyWith({
    int? id,
    int? chatId,
    int? senderId,
    int? receiverId,
    String? content,
    DateTime? sentAt,
    bool? isRead,
    bool? isPending,
  }) {
    return SignalrMessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
      isPending: isPending ?? this.isPending,
    );
  }
}