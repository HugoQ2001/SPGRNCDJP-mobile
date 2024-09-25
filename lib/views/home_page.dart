import 'package:appmobiletestis/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final User user; // El usuario autenticado

  const HomePage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el Drawer
              },
            );
          },
        ),
      ),
      drawer: const CustomDrawer(), // Drawer personalizado
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saludo personalizado con el email del usuario
            Text(
              'Hola, ${user.email}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            const SizedBox(height: 20),
            // Tarjeta 1
            buildCard(
              context,
              'Predecir Flujo de dinero',
              'Predice tu dinero y planifica el control de tu dinero.',
              'https://www.edenred.mx/hubfs/Media%20Source%202023%20%20%28imagenes%20blog%29/Diciembre/Finanzas%20empresariales%20qu%C3%A9%20son%20y%20c%C3%B3mo%20mejorarlas/finanzas-empresariales-que-son-y-como-mejorarlas.png',
              '/registers', // Ruta para la primera tarjeta
            ),
            const SizedBox(height: 20),
            // Tarjeta 2
            buildCard(
              context,
              'Más información!!!',
              'Aprende a cómo mejorar tu control del dinero.',
              'https://www.bbva.com/wp-content/uploads/2022/06/BBVA-finanzas-personales-y-corporativas.jpg',
              '/info', // Ruta para la segunda tarjeta
            ),
          ],
        ),
      ),
    );
  }
}

// Función para construir las tarjetas con información
Widget buildCard(
  BuildContext context,
  String title,
  String description,
  String imageUrl,
  String routeName,
) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName); // Navegación
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de la tarjeta
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido de la tarjeta
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
