import 'package:flutter/material.dart';
import 'package:ledgr_core/ledgr_core.dart';

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
    if (expense == null || !mounted)
      return; // user pressed back, or the screen is gone

    setState(() {
      widget.tracker.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenses =
        widget.tracker.sorted; // newest first, thanks to your getter
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
                return ListTile(
                  leading: Text(
                    expense.category.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                  title: Text(expense.title),
                  subtitle: Text(
                    '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                  ),
                  trailing: Text(formatCents(expense.amountCents)),
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
