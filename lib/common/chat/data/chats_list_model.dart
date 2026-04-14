class ChatListModel {
  final int totalChatsWithUnreadMessages;
  final PaginatedChats paginatedChats;

  ChatListModel({
    required this.totalChatsWithUnreadMessages,
    required this.paginatedChats,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      totalChatsWithUnreadMessages: json['totalChatsWithUnreadMessages'] ?? 0,
      paginatedChats: PaginatedChats.fromJson(json['paginatedChats']),
    );
  }
}

class PaginatedChats {
  final int pageIndex;
  final int pageSize;
  final int count;
  final List<ChatData> data;

  PaginatedChats({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  factory PaginatedChats.fromJson(Map<String, dynamic> json) {
    return PaginatedChats(
      pageIndex: json['pageIndex'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      count: json['count'] ?? 0,
      data: (json['data'] as List)
          .map((item) => ChatData.fromJson(item))
          .toList(),
    );
  }
}

class ChatData {
  final int chatId;
  final int otherPersonId;
  final String otherPersonName;
  final String otherPersonImage;
  final String lastMessage;
  final DateTime lastMessageDate;
  final int unreadCount;

  ChatData({
    required this.chatId,
    required this.otherPersonId,
    required this.otherPersonName,
    required this.otherPersonImage,
    required this.lastMessage,
    required this.lastMessageDate,
    required this.unreadCount,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      chatId: json['chatId'] ?? 0,
      otherPersonId: json['otherPersonId'] ?? 0,
      otherPersonName: json['otherPersonName'] ?? '',
      otherPersonImage: json['otherPersonImage'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      lastMessageDate: DateTime.parse(json['lastMessageDate']),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}