import 'package:ledgr_core/ledgr_core.dart';

ExpenseTracker createSampleTracker() {
  final tracker = ExpenseTracker();
  tracker.add(
    Expense(
      id: '1',
      title: 'Bus Fare',
      amountCents: 2000,
      category: Category.transport,
      date: DateTime(2026, 9, 10),
    ),
  );

  tracker.add(
    Expense(
      id: '2',
      title: 'Electricity',
      amountCents: 1200,
      category: Category.bills,
      date: DateTime(2026, 9, 8),
    ),
  );

  tracker.add(
    Expense(
      id: '3',
      title: 'Whatsapp',
      amountCents: 800,
      category: Category.other,
      date: DateTime(2026, 10, 9),
    ),
  );

  tracker.add(
    Expense(
      id: '4',
      title: 'Movie Box',
      amountCents: 1000,
      category: Category.fun,
      date: DateTime(2026, 10, 10),
    ),
  );

  tracker.add(
    Expense(
      id: '5',
      title: 'Lunch',
      amountCents: 2200,
      category: Category.food,
      date: DateTime(2026, 10, 14),
    ),
  );
  return tracker;
}
