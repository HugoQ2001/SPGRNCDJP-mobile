import 'package:appmobiletestis/service/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Historial extends StatefulWidget {
  final User user;

  const Historial({Key? key, required this.user}) : super(key: key);

  @override
  State<Historial> createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _expenses = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    try {
      final List<dynamic> data = await _apiService.getAllExpensesByUser(widget.user.uid);
      if (mounted) {
        setState(() {
          _expenses = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al obtener los gastos.'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _deleteExpense(int index) async {
    final expenseId = _expenses[index]['id'].toString();
    try {
      await _apiService.deleteExpense(widget.user.uid, expenseId);
      if (mounted) {
        setState(() {
          _expenses.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gasto eliminado con éxito.'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al eliminar el gasto.'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.teal[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categoría', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Gastos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                final date = DateTime.parse(expense['expense_date'] as String);
                final formattedDate = '${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}';
                final category = expense['category'] as String;
                final value = expense['expense_value'] as double;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 4,
                  child: ListTile(
                    title: Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(formattedDate),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('S/. ${value.toStringAsFixed(2)}'),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteExpense(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
