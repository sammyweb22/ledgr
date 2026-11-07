import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgr_core/ledgr_core.dart';

import '../data/expense_firestore.dart';
import 'auth_provider.dart';

final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final expensesCollectionProvider =
    Provider<CollectionReference<Map<String, dynamic>>?>((ref) {
      final user = ref.watch(authStateProvider).value;
      if (user == null) {
        return null;
      }
      return ref
          .watch(firestoreProvider)
          .collection('users')
          .doc(user.uid)
          .collection('expenses');
    });

final expensesProvider =
    StreamNotifierProvider<ExpensesNotifier, List<Expense>>(
      ExpensesNotifier.new,
    );

List<Expense> _sorted(Iterable<Expense> expenses) {
  final tracker = ExpenseTracker();
  for (final expense in expenses) {
    tracker.add(expense);
  }
  return tracker.sorted;
}

class ExpensesNotifier extends StreamNotifier<List<Expense>> {
  CollectionReference<Map<String, dynamic>>? get _collection =>
      ref.read(expensesCollectionProvider);

  List<Expense> get _current => state.value ?? const [];

  @override
  Stream<List<Expense>> build() {
    final collection = ref.watch(expensesCollectionProvider);
    if (collection == null) {
      return Stream.value(const []);
    }
    return collection.snapshots().map(
      (snapshot) => _sorted(
        snapshot.docs.map((doc) => expenseFromFirestore(doc.id, doc.data())),
      ),
    );
  }

  Future<void> add(Expense expense) async {
    state = AsyncData(_sorted([..._current, expense]));
    await _collection?.doc(expense.id).set(expenseToFirestore(expense));
  }

  Future<void> edit(Expense expense) async {
    state = AsyncData(
      _sorted(_current.map((e) => e.id == expense.id ? expense : e)),
    );
    await _collection?.doc(expense.id).set(expenseToFirestore(expense));
  }

  Future<void> remove(String id) async {
    state = AsyncData(_current.where((e) => e.id != id).toList());
    await _collection?.doc(id).delete();
  }
}

final trackerProvider = Provider<ExpenseTracker>((ref) {
  final expenses = ref.watch(expensesProvider).value ?? const <Expense>[];
  final tracker = ExpenseTracker();
  for (final expense in expenses) {
    tracker.add(expense);
  }
  return tracker;
});

final monthTotalProvider = Provider<int>((ref) {
  final now = DateTime.now();
  return ref.watch(trackerProvider).totalForMonth(now.year, now.month);
});

final categoryBreakdownProvider = Provider<Map<Category, int>>((ref) {
  final breakdown = ref.watch(trackerProvider).breakdown();
  return {
    for (final entry in breakdown.entries)
      if (entry.value > 0) entry.key: entry.value,
  };
});
