import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';
import 'provider/post_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: PapacapimApp(),
    ),
  );
}

class PapacapimApp extends StatelessWidget {
  const PapacapimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papacapim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: LoginScreen(),
    );
  }
}
