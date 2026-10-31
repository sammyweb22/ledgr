import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgr_core/ledgr_core.dart';

import '../data/sample_data.dart';

final expensesProvider = NotifierProvider<ExpensesNotifier, List<Expense>>(
  ExpensesNotifier.new,
);

class ExpensesNotifier extends Notifier<List<Expense>> {
  final _tracker = createSampleTracker();

  @override
  List<Expense> build() => _tracker.sorted;

  void add(Expense expense) {
    _tracker.add(expense);
    state = _tracker.sorted;
  }

  void update(Expense expense) {
    _tracker.update(expense);
    state = _tracker.sorted;
  }

  void remove(String id) {
    _tracker.remove(id);
    state = _tracker.sorted;
  }

  int totalForMonth(int year, int month) => _tracker.totalForMonth(year, month);
}

final monthTotalProvider = Provider<int>((ref) {
  ref.watch(expensesProvider); // re-calculate whenever the expenses change
  final now = DateTime.now();
  return ref.read(expensesProvider.notifier).totalForMonth(now.year, now.month);
});
