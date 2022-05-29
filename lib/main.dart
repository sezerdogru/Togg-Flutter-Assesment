import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togg_case/const.dart';
import 'package:togg_case/provider/auth.dart';
import 'package:togg_case/screens/locations.dart';
import 'package:togg_case/screens/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth(_)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Const.app,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: context.watch<Auth>().token == null
          ? const Login()
          : const Locations(),
    );
  }
}
