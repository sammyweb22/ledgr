import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledgr/screens/add_expense_screen.dart';
import 'package:ledgr_core/ledgr_core.dart';

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

  testWidgets('shows an error when the amount is zero', (tester) async {
    await openForm(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '0');

    await tester.tap(find.text('Save expense'));
    await tester.pump();

    expect(find.text('Amount must be positive'), findsOneWidget);
  });

  testWidgets('returns the expense when the form is valid', (tester) async {
    Expense? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              result = await Navigator.push<Expense>(
                context,
                MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
              );
            },
            child: const Text('open'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Title'),
      'Groceries',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Amount'),
      '35.75',
    );
    await tester.tap(find.text('Save expense'));
    await tester.pumpAndSettle();

    expect(result?.title, 'Groceries');
    expect(result?.amountCents, 3575);
    expect(find.text('Save expense'), findsNothing);
  });

  testWidgets('pre-fills the form when editing an expense', (tester) async {
    final lunch = Expense(
      id: '1',
      title: 'Lunch',
      amountCents: 1250,
      category: Category.food,
      date: DateTime(2026, 10, 15),
    );

    await tester.pumpWidget(
      MaterialApp(home: AddExpenseScreen(expense: lunch)),
    );

    expect(find.text('Edit expense'), findsOneWidget);
    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('12.50'), findsOneWidget);
  });
}
