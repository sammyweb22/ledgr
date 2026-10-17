import 'package:flutter/material.dart';
import 'package:ledgr_core/ledgr_core.dart';

import '../utils/format.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.tracker});

  final ExpenseTracker tracker;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _openAddExpense() async {
    final expense = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );
    if (expense == null || !mounted) {
      return;
    }

    setState(() {
      widget.tracker.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    setState(() {
      widget.tracker.remove(expense.id);
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Deleted "${expense.title}"'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                widget.tracker.add(expense);
              });
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final expenses = widget.tracker.sorted;
    final now = DateTime.now();
    final monthTotal = widget.tracker.totalForMonth(now.year, now.month);

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
