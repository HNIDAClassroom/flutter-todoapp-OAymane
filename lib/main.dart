import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/auth_verify.dart';
import 'package:todolist_app/firebase_options.dart';
import 'application.dart';
import 'package:todolist_app/authentication_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
        useMaterial3: true,
      ),
      home: AuthVerify(),
    );
  }
}
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:todolist_app/models/task.dart';
// import 'package:todolist_app/tasks.dart';
//import "login.dart";


// void main() {
//   runApp(
//     MaterialApp(
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(elevation: 0),
//         useMaterial3: true,
//       ),
//       home: const Tasks(),
//     ),
//   );
// }



// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const Login(),
//     );
//   }
// }
