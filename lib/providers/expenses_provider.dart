import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgr_core/ledgr_core.dart';

import '../data/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final expensesProvider = AsyncNotifierProvider<ExpensesNotifier, List<Expense>>(
  ExpensesNotifier.new,
);

class ExpensesNotifier extends AsyncNotifier<List<Expense>> {
  var _tracker = ExpenseTracker();

  AppDatabase get _db => ref.read(databaseProvider);

  @override
  Future<List<Expense>> build() async {
    final rows = await _db.select(_db.expenseRows).get();
    _tracker = ExpenseTracker();
    for (final row in rows) {
      _tracker.add(row.toExpense());
    }
    return _tracker.sorted;
  }

  Future<void> add(Expense expense) async {
    _tracker.add(expense);
    state = AsyncData(_tracker.sorted);
    await _db.into(_db.expenseRows).insert(expense.toRow());
  }

  Future<void> edit(Expense expense) async {
    _tracker.update(expense);
    state = AsyncData(_tracker.sorted);
    await _db.into(_db.expenseRows).insertOnConflictUpdate(expense.toRow());
  }

  Future<void> remove(String id) async {
    _tracker.remove(id);
    state = AsyncData(_tracker.sorted);
    await (_db.delete(_db.expenseRows)..where((row) => row.id.equals(id))).go();
  }

  int totalForMonth(int year, int month) => _tracker.totalForMonth(year, month);
}

final monthTotalProvider = Provider<int>((ref) {
  ref.watch(expensesProvider); // re-calculate whenever the expenses change
  final now = DateTime.now();
  return ref.read(expensesProvider.notifier).totalForMonth(now.year, now.month);
});
