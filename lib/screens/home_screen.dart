import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgr_core/ledgr_core.dart';

import '../providers/expenses_provider.dart';
import '../utils/format.dart';
import 'add_expense_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _openAddExpense() async {
    final expense = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );
    if (expense == null || !mounted) {
      return;
    }

    ref.read(expensesProvider.notifier).add(expense);
  }

  Future<void> _openEditExpense(Expense expense) async {
    final updated = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpenseScreen(expense: expense),
      ),
    );
    if (updated == null || !mounted) {
      return;
    }

    ref.read(expensesProvider.notifier).update(updated);
  }

  void _deleteExpense(Expense expense) {
    ref.read(expensesProvider.notifier).remove(expense.id);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Deleted "${expense.title}"'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              ref.read(expensesProvider.notifier).add(expense);
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expensesProvider);
    final monthTotal = ref.watch(monthTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ledgr'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('This month: ${formatCents(monthTotal)}'),
            ),
          ),
        ],
      ),
      body: expenses.isEmpty
          ? const Center(child: Text('No expenses yet'))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Dismissible(
                  key: ValueKey(expense.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                  onDismissed: (direction) => _deleteExpense(expense),
                  child: ListTile(
                    leading: Text(
                      expense.category.emoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                    title: Text(expense.title),
                    subtitle: Text(formatDate(expense.date)),
                    trailing: Text(formatCents(expense.amountCents)),
                    onTap: () => _openEditExpense(expense),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
