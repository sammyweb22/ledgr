import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledgr/providers/expenses_provider.dart';
import 'package:ledgr/screens/home_screen.dart';
import 'package:ledgr_core/ledgr_core.dart';

class FakeExpensesNotifier extends ExpensesNotifier {
  FakeExpensesNotifier(this.initial);

  final List<Expense> initial;

  @override
  Stream<List<Expense>> build() => Stream.value(initial);
}

final _now = DateTime.now();

final lunch = Expense(
  id: '1',
  title: 'Lunch',
  amountCents: 1250,
  category: Category.food,
  date: _now,
);

final bus = Expense(
  id: '2',
  title: 'Bus fare',
  amountCents: 300,
  category: Category.transport,
  date: _now,
);

final oldRent = Expense(
  id: '3',
  title: 'Old rent',
  amountCents: 99900,
  category: Category.bills,
  date: DateTime(_now.year - 1, 1, 1),
);

Future<void> pumpHome(WidgetTester tester, List<Expense> expenses) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        expensesProvider.overrideWith(() => FakeExpensesNotifier(expenses)),
        expensesCollectionProvider.overrideWithValue(null),
      ],
      child: const MaterialApp(home: HomeScreen()),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('shows each expense with its amount', (tester) async {
    await pumpHome(tester, [lunch, bus]);

    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('\$12.50'), findsOneWidget);
    expect(find.text('Bus fare'), findsOneWidget);
  });

  testWidgets('month total only counts this month', (tester) async {
    await pumpHome(tester, [lunch, bus, oldRent]);

    expect(find.text('This month: \$15.50'), findsOneWidget);
  });

  testWidgets('shows a message when there are no expenses', (tester) async {
    await pumpHome(tester, []);

    expect(find.text('No expenses yet'), findsOneWidget);
  });

  testWidgets('swiping an expense deletes it and shows a snackbar', (
    tester,
  ) async {
    await pumpHome(tester, [lunch, bus]);

    await tester.drag(find.text('Lunch'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Lunch'), findsNothing);
    expect(find.text('Deleted "Lunch"'), findsOneWidget);
    expect(find.text('This month: \$3.00'), findsOneWidget);
  });

  testWidgets('undo brings a deleted expense back', (tester) async {
    await pumpHome(tester, [lunch, bus]);

    await tester.drag(find.text('Lunch'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    expect(find.text('Lunch'), findsOneWidget);
    expect(find.text('This month: \$15.50'), findsOneWidget);
  });
}
