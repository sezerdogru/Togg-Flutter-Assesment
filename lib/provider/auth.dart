import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:togg_case/service/poi.pb.dart';
import 'package:togg_case/service/service.auth.dart';

class Auth with ChangeNotifier {
  String? _token;
  late SharedPreferences shared;
  String? get token => _token;

  Auth(BuildContext _) {
    checkLogged();
  }

  void checkLogged() async {
    shared = await SharedPreferences.getInstance();
    shared.clear();
    String? token = shared.getString("token");
    _token = token;
    notifyListeners();
  }

  void login(BuildContext ctx, String username, String password) async {
    shared = await SharedPreferences.getInstance();
    try {
      LoginReply response = await AuthService.login(username, password);
      print(response.toString());
      _token = response.token;
      shared.setString("token", response.token);
      notifyListeners();
    } catch (e) {
      log("error=${e.toString()}");
    }
  }
}
