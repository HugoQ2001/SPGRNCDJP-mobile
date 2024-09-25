class Expense {
  final String userId;
  final String category;
  final DateTime expenseDate;
  final double expenseValue;

  Expense({
    required this.userId,
    required this.category,
    required this.expenseDate,
    required this.expenseValue,
  });
}