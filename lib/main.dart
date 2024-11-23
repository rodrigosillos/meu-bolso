import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'package:meu_bolso/models/expense.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Hive e o HiveFlutter
  await Hive.initFlutter();

  // Registra o adaptador da classe Expense (se ainda não estiver registrado)
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ExpenseAdapter());
  }

  // Abre o box chamado 'expenses'
  await Hive.openBox<Expense>('expenses');

  runApp(const MeuBolsoApp());
}

class MeuBolsoApp extends StatelessWidget {
  const MeuBolsoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Bolso',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
