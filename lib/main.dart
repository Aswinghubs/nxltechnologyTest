import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nxltechmachinetest/ControllerPage/authprovider.dart';
import 'package:provider/provider.dart';

import 'package:nxltechmachinetest/viewPage/loginPageView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nxltechmachinetest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
