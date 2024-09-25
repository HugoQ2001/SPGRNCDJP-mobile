import 'package:appmobiletestis/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecordExpenses extends StatefulWidget {
  const RecordExpenses({super.key});

  @override
  State<RecordExpenses> createState() => _RecordExpensesState();
}

class _RecordExpensesState extends State<RecordExpenses> {
  String result = '0.00';
  DateTime? selectedDate;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  static const IconData calendar_today = IconData(0xe122, fontFamily: 'MaterialIcons');
  final ApiService _apiService = ApiService(); // Usa ApiService en lugar de Dio

  @override
  void initState() {
    super.initState();
    myController.addListener(_sumValues);
    myController2.addListener(_sumValues);
    myController3.addListener(_sumValues);
  }

  void _sumValues() {
    double text1 = double.tryParse(myController.text) ?? 0.0;
    double text2 = double.tryParse(myController2.text) ?? 0.0;
    double text3 = double.tryParse(myController3.text) ?? 0.0;

    setState(() {
      result = (text1 + text2 + text3).toStringAsFixed(2);
    });
  }

  Future<void> _selectMonthYear(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, 15);
      });
    }
  }

  Future<void> _registerExpenses() async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No está seleccionada la fecha'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay usuario autenticado'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String userId = user.uid;

    final Map<String, dynamic> data = {
      'id': 0, // Agrega un ID si es necesario o deja en 0 si el servidor lo asigna
      'user_id': userId,
      'category': 'Entretenimiento', // Valor predeterminado
      'expense_date': selectedDate != null ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-01' : null,
      'expense_value': double.tryParse(result) ?? 0.0,
    };

    try {
      final response = await _apiService.createExpenses(data); // Usa ApiService aquí
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gasto registrado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
      print(response);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar el gasto: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Registrar Gastos',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.start,
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: const Color.fromARGB(255, 211, 83, 83),
            child: SizedBox(
              height: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(calendar_today),
                    onPressed: () => _selectMonthYear(context),
                  ),
                  const Text('Entretenimiento'),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 199, 192, 192),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 40,
                    width: 160,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('S/. $result'),
                          const Icon(Icons.monetization_on_outlined),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selectedDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Fecha seleccionada: ${selectedDate!.month}/${selectedDate!.year}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: const Color.fromARGB(255, 236, 232, 232),
            child: SizedBox(
              height: 270,
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(width: 20),
                        const Text('Fiestas'),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                            ],
                            controller: myController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: 'S/.',
                              suffixIcon: Icon(Icons.monetization_on_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(width: 20),
                        const Text('Cine'),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                            ],
                            controller: myController2,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: 'S/.',
                              suffixIcon: Icon(Icons.monetization_on_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(width: 20),
                        const Text('Restaurantes'),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                            ],
                            controller: myController3,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: 'S/.',
                              suffixIcon: Icon(Icons.monetization_on_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 29, 129, 168),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: _registerExpenses,
            child: const Text(
              "Registrar Gastos Mensuales",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
