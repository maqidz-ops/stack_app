import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/users_model.dart';

class UsersController {

  static const String url =
      "https://6a43cfa66dba791499ab71bb.mockapi.io/users";

  Future<List<Users>> getUsers() async {

    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {

      List<dynamic> data =
          jsonDecode(response.body);

      return data
          .map((e) => Users.fromJson(e))
          .toList();

    } else {
      throw Exception(
          "Failed to load users");
    }
  }

  Future<bool> login(
      String email,
      String password) async {

    List<Users> users =
        await getUsers();

    for (var user in users) {
      if (user.email == email &&
          user.password == password) {
        return true;
      }
    }

    return false;
  }
}