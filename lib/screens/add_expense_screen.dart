import 'package:flutter/material.dart';
import 'package:ledgr_core/ledgr_core.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add expense')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            final expense = Expense(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              title: 'Test expense',
              amountCents: 500,
              category: Category.other,
              date: DateTime.now(),
            );
            Navigator.pop(context, expense);
          },
          child: const Text('Save test expense'),
        ),
      ),
    );
  }
}
