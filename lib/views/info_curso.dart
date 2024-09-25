import 'package:appmobiletestis/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCursos extends StatelessWidget {
  const InfoCursos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
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
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildCard(
                context,
                '¿Cómo ahorrar?',
                'Conoce cómo ahorrar y planifica mejor tu dinero.',
                'https://www.scotiabank.com.pe/blog/consejos-para-ahorrar-dinero',
                'https://www.bbva.com/wp-content/uploads/2022/06/BBVA-finanzas-personales-y-corporativas.jpg',
              ),
              const SizedBox(height: 20),
              buildCard(
                context,
                '¿Qué son los gastos hormiga?',
                'Aprende qué son los gastos hormiga y cómo puedes ahorrar mucho más.',
                'https://www.bbva.com/es/pe/salud-financiera/que-son-los-gastos-hormiga-fantasma-y-vampiro-y-como-identificarlos/',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQkwy7vikAjyhAG9pvADSAPmT3941sUE8_iQ&s',
              ),
              const SizedBox(height: 20),
              buildCard(
                context,
                '¿Cómo hacer un presupuesto?',
                'Aprende cómo realizar un presupuesto para controlar tus gastos.',
                'https://www.santander.com.mx/educacion-financiera/blog/6-pasos-para-armar-un-presupuesto/index.html',
                'https://www.edenred.mx/hubfs/Media%20Source%202023%20%20%28imagenes%20blog%29/Diciembre/Finanzas%20empresariales%20qu%C3%A9%20son%20y%20c%C3%B3mo%20mejorarlas/finanzas-empresariales-que-son-y-como-mejorarlas.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCard(
  BuildContext context,
  String title,
  String description,
  String url,
  String imageUrl,
) {
  return InkWell(
    onTap: () async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'No se pudo abrir $url';
      }
    },
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen que ocupa el 30% del ancho y toda la altura del Card
          Container(
            width: MediaQuery.of(context).size.width * 0.3, // 30% del ancho de la pantalla
            height: 150, // Ajusta la altura según sea necesario
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el contenedor
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Descripción
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