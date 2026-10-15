import 'package:flutter/material.dart';
import 'package:ledgr_core/ledgr_core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.tracker});

  final ExpenseTracker tracker;

  @override
  Widget build(BuildContext context) {
    final expenses = tracker.sorted; // newest first, thanks to your getter
    final now = DateTime.now();
    final monthTotal = tracker.totalForMonth(now.year, now.month);

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
    );
  }
}
