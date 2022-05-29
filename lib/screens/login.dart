import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togg_case/const.dart';
import 'package:togg_case/provider/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  void login(BuildContext context) {
    String username = usernameCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    context.read<Auth>().login(context, username, password);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameCtrl.text = "Test";
    passwordCtrl.text = "Togg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Const.loginTitle),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: usernameCtrl,
              key: const Key("username"),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: Const.username,
                hintText: Const.usernameHint,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              key: const Key("password"),
              obscureText: true,
              controller: passwordCtrl,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: Const.password,
                hintText: Const.passwordHint,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () => login(context),
              child: Text(
                Const.login,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
