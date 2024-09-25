import 'package:appmobiletestis/firebase_options.dart';
import 'package:appmobiletestis/login.dart';
import 'package:appmobiletestis/registerauth.dart';
import 'package:appmobiletestis/views/home_page.dart';
import 'package:appmobiletestis/views/info_curso.dart';
import 'package:appmobiletestis/views/registers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/registerauth': (context) => const RegisterPage(),
        '/homepage': (context) {
          final User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            return HomePage(user: user);
          } else {
            return LoginPage();
          }
        },
        '/registers': (context) {
          final User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            return RegistersView(user: user);
          } else {
            return LoginPage();
          }
        },
        '/info': (context) => const InfoCursos(),
      },
    );
  }
}
