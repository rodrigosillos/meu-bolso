import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:meu_bolso/data/hive_database.dart';
import 'package:meu_bolso/models/expense.dart';

void main() {
  setUpAll(() async {
    // Inicializa o Hive para o ambiente de teste
    Hive.init('./test/hive_test');

    // Registra o adaptador para o modelo Expense
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExpenseAdapter());
    }
  });

  setUp(() async {
    // Limpa qualquer box existente antes de abrir um novo
    if (await Hive.boxExists('expenses')) {
      await Hive.deleteBoxFromDisk('expenses');
    }
    await Hive.openBox<Expense>('expenses');
  });

  tearDown(() async {
    // Fecha e limpa o box após cada teste
    if (Hive.isBoxOpen('expenses')) {
      await Hive.box<Expense>('expenses').clear();
      await Hive.box<Expense>('expenses').close();
    }
  });

  group('Hive Database', () {
    test('Adiciona despesa ao banco de dados', () async {
      // Cria uma despesa de teste
      final expense = Expense(
        description: 'Café',
        amount: 10.0,
        date: DateTime.now(),
      );

      // Adiciona ao banco de dados
      await HiveDatabase.addExpense(expense);

      // Recupera todas as despesas
      final expenses = HiveDatabase.getExpenses();

      // Verifica se a despesa foi adicionada corretamente
      expect(expenses.length, 1);
      expect(expenses.first.description, 'Café');
      expect(expenses.first.amount, 10.0);
    });

    test('Recupera despesas do banco de dados', () async {
      // Cria e adiciona despesas ao banco de dados
      final expense1 = Expense(
        description: 'Almoço',
        amount: 25.0,
        date: DateTime.now(),
      );
      final expense2 = Expense(
        description: 'Jantar',
        amount: 50.0,
        date: DateTime.now(),
      );

      await HiveDatabase.addExpense(expense1);
      await HiveDatabase.addExpense(expense2);

      // Recupera todas as despesas
      final expenses = HiveDatabase.getExpenses();

      // Verifica se todas as despesas foram recuperadas corretamente
      expect(expenses.length, 2);
      expect(expenses[0].description, 'Almoço');
      expect(expenses[1].description, 'Jantar');
    });
  });
}
