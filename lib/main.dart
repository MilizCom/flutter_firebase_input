import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dashBoard.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors
              .deepPurple, // Use primarySwatch for a consistent color scheme.
        ),
        // Other theme configurations...
      ),
      home: DashBoard(),
    );
  }
}
