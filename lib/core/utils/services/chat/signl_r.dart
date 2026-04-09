import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection hubConnection;
  final String serverUrl = "https://your-api-url.com/chatHub"; // هيتغير لما الباك يبعت

  // ميثود لبدء الاتصال
  Future<void> startConnection() async {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

    hubConnection.onclose(({error}) => print("Connection Closed"));

    if (hubConnection.state != HubConnectionState.Connected) {
      await hubConnection.start();
      print("SignalR Connected!");
    }
  }

  // 1. استقبال رسالة (Receive Message)
  void receiveMessageListener(Function(dynamic) onMessageReceived) {
    hubConnection.on("ReceiveMessage", (arguments) {
      onMessageReceived(arguments);
    });
  }

  // 2. إرسال رسالة (Send Message)
  Future<void> sendMessage(String receiverId, String message) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.invoke("SendMessage", args: [receiverId, message]);
    }
  }

  // 3. تحديد الرسالة كمقروءة (Mark as Read)
  Future<void> markAsRead(String messageId) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.invoke("MarkAsRead", args: [messageId]);
    }
  }

  // 4. السماع لحدث أن الطرف الآخر قرأ الرسالة (On Message Read)
  void onMessageReadListener(Function(dynamic) onRead) {
    hubConnection.on("MessageReadNotification", (arguments) {
      onRead(arguments);
    });
  }

  // إغلاق الاتصال
  Future<void> stopConnection() async {
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.stop();
      print("SignalR Connection Stopped");
    }
  }
}