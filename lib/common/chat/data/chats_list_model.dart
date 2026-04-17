class ChatListModel {
  final int totalChatsWithUnreadMessages;
  final PaginatedChats? paginatedChats; 

  ChatListModel({
    required this.totalChatsWithUnreadMessages,
    this.paginatedChats,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    T? readValue<T>(String key) {
      final lowercaseKey = key.toLowerCase();
      for (var entry in json.entries) {
        if (entry.key.toLowerCase() == lowercaseKey) return entry.value as T?;
      }
      return null;
    }

    return ChatListModel(
      totalChatsWithUnreadMessages: readValue<int>('totalChatsWithUnreadMessages') ?? 
                                    readValue<int>('totalunread') ?? 0,
      paginatedChats: json.containsKey('paginatedChats') || json.containsKey('PaginatedChats')
          ? PaginatedChats.fromJson(json['paginatedChats'] ?? json['PaginatedChats'])
          : null,
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
    T? readValue<T>(String key) {
      final lowercaseKey = key.toLowerCase();
      for (var entry in json.entries) {
        if (entry.key.toLowerCase() == lowercaseKey) return entry.value as T?;
      }
      return null;
    }

    var listData = readValue<List>('data') ?? [];

    return PaginatedChats(
      pageIndex: readValue<int>('pageIndex') ?? 0,
      pageSize: readValue<int>('pageSize') ?? 0,
      count: readValue<int>('count') ?? 0,
      data: listData.map((item) => ChatData.fromJson(item)).toList(),
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
    T? readValue<T>(String key) {
      final lowercaseKey = key.toLowerCase();
      for (var entry in json.entries) {
        if (entry.key.toLowerCase() == lowercaseKey) return entry.value as T?;
      }
      return null;
    }

    return ChatData(
      chatId: readValue<int>('chatId') ?? 0,
      otherPersonId: readValue<int>('otherPersonId') ?? readValue<int>('otherId') ?? 0,
      otherPersonName: readValue<String>('otherPersonName') ?? readValue<String>('name') ?? '',
      otherPersonImage: readValue<String>('otherPersonImage') ?? readValue<String>('image') ?? '',
      lastMessage: readValue<String>('lastMessage') ?? '',
      lastMessageDate: readValue<String>('lastMessageDate') != null 
          ? DateTime.parse(readValue<String>('lastMessageDate')!) 
          : DateTime.now(),
      unreadCount: readValue<int>('unreadCount') ?? 0,
    );
  }

  ChatData copyWith({
    int? chatId,
    int? otherPersonId,
    String? otherPersonName,
    String? otherPersonImage,
    String? lastMessage,
    DateTime? lastMessageDate,
    int? unreadCount,
  }) {
    return ChatData(
      chatId: chatId ?? this.chatId,
      otherPersonId: otherPersonId ?? this.otherPersonId,
      otherPersonName: otherPersonName ?? this.otherPersonName,
      otherPersonImage: otherPersonImage ?? this.otherPersonImage,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageDate: lastMessageDate ?? this.lastMessageDate,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}


// class ChatListModel {
//   final int totalChatsWithUnreadMessages;
//   final PaginatedChats paginatedChats;

//   ChatListModel({
//     required this.totalChatsWithUnreadMessages,
//     required this.paginatedChats,
//   });

//   factory ChatListModel.fromJson(Map<String, dynamic> json) {
//     return ChatListModel(
//       totalChatsWithUnreadMessages: json['totalChatsWithUnreadMessages'] ?? 0,
//       paginatedChats: PaginatedChats.fromJson(json['paginatedChats']),
//     );
//   }
// }

// class PaginatedChats {
//   final int pageIndex;
//   final int pageSize;
//   final int count;
//   final List<ChatData> data;

//   PaginatedChats({
//     required this.pageIndex,
//     required this.pageSize,
//     required this.count,
//     required this.data,
//   });

//   factory PaginatedChats.fromJson(Map<String, dynamic> json) {
//     return PaginatedChats(
//       pageIndex: json['pageIndex'] ?? 0,
//       pageSize: json['pageSize'] ?? 0,
//       count: json['count'] ?? 0,
//       data: (json['data'] as List)
//           .map((item) => ChatData.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class ChatData {
//   final int chatId;
//   final int otherPersonId;
//   final String otherPersonName;
//   final String otherPersonImage;
//   final String lastMessage;
//   final DateTime lastMessageDate;
//   final int unreadCount;

//   ChatData({
//     required this.chatId,
//     required this.otherPersonId,
//     required this.otherPersonName,
//     required this.otherPersonImage,
//     required this.lastMessage,
//     required this.lastMessageDate,
//     required this.unreadCount,
//   });

 
//   ChatData copyWith({
//     int? chatId,
//     int? otherPersonId,
//     String? otherPersonName,
//     String? otherPersonImage,
//     String? lastMessage,
//     DateTime? lastMessageDate,
//     int? unreadCount,
//   }) {
//     return ChatData(
//       chatId: chatId ?? this.chatId,
//       otherPersonId: otherPersonId ?? this.otherPersonId,
//       otherPersonName: otherPersonName ?? this.otherPersonName,
//       otherPersonImage: otherPersonImage ?? this.otherPersonImage,
//       lastMessage: lastMessage ?? this.lastMessage,
//       lastMessageDate: lastMessageDate ?? this.lastMessageDate,
//       unreadCount: unreadCount ?? this.unreadCount,
//     );
//   }

//   factory ChatData.fromJson(Map<String, dynamic> json) {
//     return ChatData(
//       chatId: json['chatId'] ?? 0,
//       otherPersonId: json['otherPersonId'] ?? 0,
//       otherPersonName: json['otherPersonName'] ?? '',
//       otherPersonImage: json['otherPersonImage'] ?? '',
//       lastMessage: json['lastMessage'] ?? '',
//       lastMessageDate: DateTime.parse(json['lastMessageDate']),
//       unreadCount: json['unreadCount'] ?? 0,
//     );
//   }
// }