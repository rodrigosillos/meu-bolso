import 'package:flutter/material.dart';
import '../data/hive_database.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Expense> expenses;

  @override
  void initState() {
    super.initState();
    expenses = HiveDatabase.getExpenses();
  }

  double calculateTotal() {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Bolso'),
      ),
      body: Column(
        children: [
          Expanded(
            child: expenses.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma despesa cadastrada.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return ListTile(
                        title: Text(expense.description),
                        subtitle: Text(
                          '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                        ),
                        trailing: Text(
                          'R\$ ${expense.amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            color: Colors.purple.shade100,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total das despesas:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'R\$ ${calculateTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 64.0), // Ajusta a altura
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddExpenseScreen(),
              ),
            );

            if (result == true) {
              setState(() {
                expenses = HiveDatabase.getExpenses();
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
