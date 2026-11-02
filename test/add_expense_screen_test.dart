import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledgr/screens/add_expense_screen.dart';

void main() {
  Future<void> openForm(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddExpenseScreen()));
  }

  testWidgets('shows the Add expense title for a new expense', (tester) async {
    await openForm(tester);

    expect(find.text('Add expense'), findsOneWidget);
  });

  testWidgets('shows errors when saving an empty form', (tester) async {
    await openForm(tester);

    await tester.tap(find.text('Save expense'));
    await tester.pump();

    expect(find.text('Please enter a title'), findsOneWidget);
    expect(find.text('Please enter a number'), findsOneWidget);
  });

  testWidgets('shows errors when saving an empty form', (tester) async {
    await openForm(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '0');

    await tester.tap(find.text('Save expense'));
    await tester.pump();

    expect(find.text('Amount must be positive'), findsOneWidget);
  });
}
