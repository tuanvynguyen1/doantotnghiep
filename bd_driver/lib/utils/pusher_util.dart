import 'package:pusher_client/pusher_client.dart';

class PusherUtil {
  static Future<void> connect(token) async {
    print('Bearer $token');
    PusherOptions options = PusherOptions(
      host: '20.2.66.17',
      wsPort: 6001,
      cluster: 'ap1',
      encrypted: false,

      auth: PusherAuth(
        'http://20.2.66.17:8000/auth',
        headers: {
          'Content-Type' : "application/json",
          'Authorization': 'Bearer 5|IBnK29a587NqdicHZZD4nB6geqwuPd3ZIhqZxzDn',
          'Accept' : 'application/json'
        },
      ),
    );

    PusherClient pusher =
        PusherClient('fb82f63095488eb9cf78', options, autoConnect: false);

// connect at a later time than at instantiation.
    pusher.connect();

    pusher.onConnectionStateChange((state) {
      print(
          "previousState: ${state?.previousState}, currentState: ${state?.currentState}");
    });

    pusher.onConnectionError((error) {
      print("error: ${error?.message}");
    });

// Subscribe to a private channel
    Channel channel = pusher.subscribe("private-orders");

// Bind to listen for events called "order-status-updated" sent to "private-orders" channel
    channel.bind("order-status-updated", (event) {
      print(event?.data);
    });

// Unsubscribe from channel
    pusher.unsubscribe("private-orders");

// Disconnect from pusher service
    pusher.disconnect();
  }
}
