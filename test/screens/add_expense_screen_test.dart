import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meu_bolso/screens/add_expense_screen.dart';

void main() {
  testWidgets('AddExpenseScreen tem campos e botão', (WidgetTester tester) async {
    // Carrega a tela AddExpenseScreen
    await tester.pumpWidget(
      const MaterialApp(
        home: AddExpenseScreen(),
      ),
    );

    // Verifica se há dois TextFields (Descrição e Valor)
    expect(find.byType(TextField), findsNWidgets(2));

    // Verifica o título da tela
    expect(find.text('Adicionar Despesa'), findsOneWidget);

    // Verifica o campo "Descrição"
    expect(find.text('Descrição'), findsOneWidget);

    // Verifica o campo "Valor (R$)"
    expect(find.text('Valor (R\$)'), findsOneWidget);

    // Verifica o botão de selecionar data
    expect(find.text('Selecionar Data'), findsOneWidget);

    // Verifica o botão de salvar
    expect(find.text('Salvar'), findsOneWidget);
  });
}
