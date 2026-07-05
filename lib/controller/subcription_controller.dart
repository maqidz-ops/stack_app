import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/subscription_model.dart';

class SubscriptionController {
  static const String url =
      "https://6a43cfa66dba791499ab71bb.mockapi.io/subscription";

  Future<List<SubscriptionModel>> getSubscriptions() async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => SubscriptionModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load subscriptions");
    }
  }
}