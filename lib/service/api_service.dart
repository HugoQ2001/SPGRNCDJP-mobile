import 'package:appmobiletestis/model/expense.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://spgrncdjp-api-bnb8g8hqchd7g4d4.canadacentral-01.azurewebsites.net/',
    connectTimeout: Duration(milliseconds: 12000),
    receiveTimeout: Duration(milliseconds: 12000),
  ));

  // Obtener todos los gastos de un usuario
  Future<List<dynamic>> getAllExpensesByUser(String userId) async {
    try {
      final response = await _dio.get('/expenses/user/$userId');
      
      // Imprime el código de estado y el cuerpo de la respuesta para depuración
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.data}');
      
      // Aseguramos que la respuesta sea una lista
      return response.data as List<dynamic>;
    } catch (e) {
      // Captura cualquier excepción que pueda ocurrir
      print('Error fetching expenses: $e');
      throw Exception('Failed to load data');
    }
  }

  // los 5 ultimos gastos
  // En ApiService.dart
Future<List<Expense>> getLimitExpensesByUser(String userId) async {
  try {
    final response = await _dio.get('/expenses/limit/user/$userId');
    
    // Imprime el código de estado y el cuerpo de la respuesta para depuración
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.data}');
    
    // Convierte la respuesta en una lista de Expense
    List<Expense> expenses = (response.data as List<dynamic>).map((item) {
      return Expense(
        userId: item['user_id'],
        category: item['category'],
        expenseDate: DateTime.parse(item['expense_date']),
        expenseValue: item['expense_value'].toDouble(),
      );
    }).toList();
    
    return expenses;
  } catch (e) {
    // Captura cualquier excepción que pueda ocurrir
    print('Error fetching expenses: $e');
    throw Exception('Failed to load data');
  }
}


  Future<List<dynamic>> getLastExpensesByUser(String userId) async {
  try {
    final response = await _dio.get('/expense/last/user/$userId');
    
    // Imprime el código de estado y el cuerpo de la respuesta para depuración
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.data}');
    
    // Si la respuesta es un solo objeto, lo convierte en una lista
    if (response.data is Map<String, dynamic>) {
      return [response.data]; // Devuelve como lista de un solo elemento
    }

    // Si la respuesta ya es una lista, simplemente la retorna
    return response.data as List<dynamic>;
  } catch (e) {
    // Captura cualquier excepción que pueda ocurrir
    print('Error fetching expenses: $e');
    throw Exception('Failed to load data');
  }
}

  // Método para hacer una solicitud POST
  Future<Map<String, dynamic>> createExpenses(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/expenses', data: data);
      
      // Imprime el código de estado y el cuerpo de la respuesta para depuración
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.data}');
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      // Captura cualquier excepción que pueda ocurrir
      print('Error creating expense: $e');
      throw Exception('Failed to post data');
    }
  }

  // Método para hacer una solicitud POST
  Future<Map<String, dynamic>> createPronostication(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/pronostications', data: data);
      
      // Imprime el código de estado y el cuerpo de la respuesta para depuración
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.data}');
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      // Captura cualquier excepción que pueda ocurrir
      print('Error creating expense: $e');
      throw Exception('Failed to post data');
    }
  }

  Future<List<dynamic>> getPronosticationByUser(String userId) async {
  try {
    final response = await _dio.get('/pronostications/user/$userId');
    
    // Imprime el código de estado y el cuerpo de la respuesta para depuración
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.data}');
    
    // Si la respuesta es un solo objeto, lo convierte en una lista
    if (response.data is Map<String, dynamic>) {
      return [response.data]; // Devuelve como lista de un solo elemento
    }

    // Si la respuesta ya es una lista, simplemente la retorna
    return response.data as List<dynamic>;
  } catch (e) {
    // Captura cualquier excepción que pueda ocurrir
    print('Error fetching expenses: $e');
    throw Exception('Failed to load data');
  }
}



  Future<void> deleteExpense(String userId, String expenseId) async {
    try {
      final response = await _dio.delete('/expenses/delete/user/$userId/$expenseId');
      
      // Imprime el código de estado para depuración
      print('Response Status Code: ${response.statusCode}');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      // Captura cualquier excepción que pueda ocurrir
      print('Error deleting expense: $e');
      throw Exception('Failed to delete data');
    }
  }
}
