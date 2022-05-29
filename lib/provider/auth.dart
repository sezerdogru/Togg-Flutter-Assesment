import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:togg_case/const.dart';
import 'package:togg_case/screens/locations.dart';
import 'package:togg_case/service/poi.pb.dart';
import 'package:togg_case/service/service.auth.dart';
import 'package:togg_case/widgets/alert.dart';

class Auth with ChangeNotifier {
  String? _token;
  late SharedPreferences shared;
  String? get token => _token;

  Auth(BuildContext _) {
    checkLogged();
  }

  void checkLogged() async {
    shared = await SharedPreferences.getInstance();
    String? token = shared.getString("token");
    _token = token;
    notifyListeners();
  }

  void login(BuildContext ctx, String username, String password) async {
    shared = await SharedPreferences.getInstance();
    if (username.isEmpty || password.isEmpty) {
      Alert.showAlertDialog(
        ctx,
        Const.fillAllFields,
        buttonText: Const.ok,
        errTitle: Const.loginError,
      );
      return;
    }
    try {
      LoginReply response = await AuthService.login(username, password);
      _token = response.token;
      shared.setString("token", response.token);
      notifyListeners();
      Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
              builder: (BuildContext context) => const Locations()));
    } on GrpcError catch (e) {
      log(e.message.toString());
      Alert.showAlertDialog(
        ctx,
        e.message!,
        buttonText: Const.ok,
        errTitle: Const.loginError,
      );
    }
  }
}
