import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meu_bolso/models/expense.dart';
import 'package:meu_bolso/screens/home_screen.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

// Mock para o PathProvider
class MockPathProvider extends PathProviderPlatform {
  @override
  Future<String> getApplicationDocumentsPath() async {
    return './test/hive_test';
  }
}

void main() {
  setUpAll(() async {
    // Registra o mock do PathProvider
    PathProviderPlatform.instance = MockPathProvider();

    // Inicializa o Hive para o ambiente de teste
    await Hive.initFlutter('./test/hive_test');

    // Registra o adaptador apenas se ele ainda não estiver registrado
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExpenseAdapter());
    }
  });

  setUp(() async {
    // Abre o box apenas se ele não estiver aberto
    if (!Hive.isBoxOpen('expenses')) {
      await Hive.openBox<Expense>('expenses');
    }
  });

  tearDown(() async {
    // Limpa os dados e fecha o box após cada teste
    if (Hive.isBoxOpen('expenses')) {
      await Hive.box<Expense>('expenses').clear();
      await Hive.box<Expense>('expenses').close();
    }
  });

  group('HomeScreen', () {
    testWidgets('HomeScreen mostra mensagem inicial', (WidgetTester tester) async {
      // Configura o ambiente para exibir a tela HomeScreen
      await tester.pumpWidget(
        MaterialApp(
          home: const HomeScreen(),
        ),
      );

      // Aguarda a renderização inicial da tela
      await tester.pumpAndSettle();

      // Verifica se os elementos corretos estão na tela
      expect(find.text('Nenhuma despesa cadastrada.'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}
