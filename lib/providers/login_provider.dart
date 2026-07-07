import 'package:flutter/foundation.dart';

import '../controller/auth_controller.dart';
import '../model/users_model.dart';

class LoginProvider extends ChangeNotifier {
  final AuthController _authController = AuthController();

  bool _isLoading = false;
  Users? _user;
  String? _error;

  bool get isLoading => _isLoading;
  Users? get user => _user;
  String? get error => _error;

  Future<bool> login({required String email, required String password}) async {
    _setLoading(true);
    _error = null;

    try {
      final result = await _authController.login(email: email, password: password);
      _user = result;
      return _user != null;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
