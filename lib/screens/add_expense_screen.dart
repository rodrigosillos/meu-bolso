import 'package:flutter/material.dart';
import '../data/hive_database.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    final description = _descriptionController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());
    
    if (description.isEmpty || amount == null || amount <= 0 || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newExpense = Expense(
      description: description,
      amount: amount,
      date: _selectedDate!,
    );

    HiveDatabase.addExpense(newExpense);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Despesa adicionada com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true); // Retorna à tela inicial e sinaliza sucesso.
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Despesa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveExpense,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
