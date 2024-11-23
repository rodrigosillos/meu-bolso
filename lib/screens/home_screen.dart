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
    // Inicializa a lista de despesas a partir do banco de dados
    expenses = HiveDatabase.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Bolso'),
      ),
      body: expenses.isEmpty
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navega para a tela de adicionar despesas
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen(),
            ),
          );

          // Atualiza a lista de despesas caso uma nova seja adicionada
          if (result == true) {
            setState(() {
              expenses = HiveDatabase.getExpenses();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
