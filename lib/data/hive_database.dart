import 'package:hive/hive.dart';
import '../models/expense.dart';

class HiveDatabase {
  static const String boxName = 'expenses';

  static Future<void> init() async {
    Hive.registerAdapter(ExpenseAdapter());
    await Hive.openBox<Expense>(boxName);
  }

  static Future<void> addExpense(Expense expense) async {
    final box = Hive.box<Expense>(boxName);
    await box.add(expense);
  }

  static List<Expense> getExpenses() {
    final box = Hive.box<Expense>(boxName);
    return box.values.toList();
  }
}
