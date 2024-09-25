import 'package:appmobiletestis/views/tabs_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistersView extends StatelessWidget {
  final User user; // Asegúrate de que esta propiedad sea proporcionada

  const RegistersView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabsBar(user: user),
    );
  }
}
