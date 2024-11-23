import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:meu_bolso/models/expense.dart';

void main() {
  setUpAll(() {
    // Inicializa o Hive para o ambiente de teste
    Hive.init('./test/hive_test');

    // Registra o adaptador para o modelo Expense
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExpenseAdapter());
    }
  });

  group('Expense Model', () {
    test('Converte para Map corretamente', () {
      final expense = Expense(
        description: 'Almoço',
        amount: 25.50,
        date: DateTime(2024, 11, 22),
      );

      final expenseMap = expense.toMap();

      expect(expenseMap['description'], 'Almoço');
      expect(expenseMap['amount'], 25.50);
      expect(expenseMap['date'], '2024-11-22T00:00:00.000');
    });

    test('Constrói a partir de Map corretamente', () {
      final expenseMap = {
        'description': 'Jantar',
        'amount': 50.0,
        'date': '2024-11-22T00:00:00.000',
      };

      final expense = Expense.fromMap(expenseMap);

      expect(expense.description, 'Jantar');
      expect(expense.amount, 50.0);
      expect(expense.date, DateTime.parse('2024-11-22T00:00:00.000'));
    });
  });
}
