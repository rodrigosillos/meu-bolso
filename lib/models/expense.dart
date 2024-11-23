import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  Expense({
    required this.description,
    required this.amount,
    required this.date,
  });

  // Método para converter para Map
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(), // Formato ISO para garantir compatibilidade
    };
  }

  // Método para construir a partir de Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date'] as String), // Parse da string ISO
    );
  }
}
