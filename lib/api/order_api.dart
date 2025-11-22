import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderAPI {
  static const String url1 =
      "https://6921934e512fb4140be0a867.mockapi.io/api/v1/orders";

  static Future<bool> sendOrderToAPI(Order order) async {
    final response = await http.post(
      Uri.parse(url1),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        // "id": order.id,          // ❌ JANGAN KIRIM ID
        "userId": order.userId,
        "items": order.items.map((item) => item.toMap()).toList(),
        "total": order.total,
        "date": order.date.toIso8601String(),
        "paymentMethod": order.paymentMethod,
        "status": order.status,
      }),
    );

    print("STATUS API: ${response.statusCode}");
    print("RESPONSE: ${response.body}");

    return response.statusCode == 201;
  }
}
