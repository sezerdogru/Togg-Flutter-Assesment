import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:togg_case/service/poi.pb.dart';
import 'package:togg_case/service/service.auth.dart';

class Auth with ChangeNotifier {
  String _token = "";

  String get token => _token;

  void login(String username, String password) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    try {
      LoginReply response = await AuthService.login(username, password);
      _token = response.token;
      shared.setString("token", response.token);
      notifyListeners();
    } catch (e) {
      log("error=${e.toString()}");
    }
  }
}
