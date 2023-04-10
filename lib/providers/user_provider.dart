import 'package:flutter/material.dart';
import 'package:pufferpanel/api/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  String? get username => _user?.username;
  String? get email => _user?.email;
  String? get password => _user?.password;
  int? get id => _user?.id;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
