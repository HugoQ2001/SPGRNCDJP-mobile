import 'package:appmobiletestis/views/historial.dart';
import 'package:appmobiletestis/views/record_expenses.dart';
import 'package:appmobiletestis/widgets/custom_drawer.dart';
import 'package:appmobiletestis/widgets/table.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabsBar extends StatelessWidget {
  final User user; // Asegúrate de que esta propiedad sea proporcionada

  const TabsBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Abrir el Drawer
                },
              );
            },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Estadisticas',
              ),
              Tab(
                text: 'Gastos', 
              ),
              Tab(
                text: 'Historial',
              ),
            ],
          ),
        ),
        drawer: const CustomDrawer(),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: TablaView(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: RecordExpenses(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: Historial(user: user), // Pasar el userId aquí
            ),
          ],
        ),
      ),
    );
  }
}
