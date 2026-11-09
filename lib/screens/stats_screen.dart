import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgr_core/ledgr_core.dart';

import '../providers/budget_provider.dart';
import '../providers/expenses_provider.dart';
import '../services/notification_service.dart';
import '../utils/format.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  Color _colorFor(Category category, ColorScheme colors) => switch (category) {
    Category.food => colors.primary,
    Category.transport => colors.secondary,
    Category.bills => colors.tertiary,
    Category.fun => colors.error,
    Category.other => colors.outline,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakdown = ref.watch(categoryBreakdownProvider);
    final total = breakdown.values.fold<int>(0, (sum, cents) => sum + cents);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Spending by category')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _BudgetCard(),
          const SizedBox(height: 24),
          if (total == 0)
            const Center(child: Text('No expenses yet'))
          else ...[
            SizedBox(
              height: 240,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  sections: [
                    for (final entry in breakdown.entries)
                      PieChartSectionData(
                        value: entry.value.toDouble(),
                        color: _colorFor(entry.key, colors),
                        title: '${(entry.value * 100 / total).round()}%',
                        radius: 60,
                        titleStyle: TextStyle(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            for (final entry in breakdown.entries)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: _colorFor(entry.key, colors),
                  child: Text(entry.key.emoji),
                ),
                title: Text(entry.key.label),
                trailing: Text(formatMoney(entry.value)),
              ),
          ],
        ],
      ),
    );
  }
}

class _BudgetCard extends ConsumerWidget {
  const _BudgetCard();

  Future<void> _editBudget(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) => _BudgetDialog(initial: ref.read(budgetProvider)),
    );
    if (result == null) {
      return;
    }
    ref.read(budgetProvider.notifier).setBudget(result == 0 ? null : result);
    if (result > 0) {
      await ref.read(notificationServiceProvider).requestPermission();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budget = ref.watch(budgetProvider);
    final spent = ref.watch(monthTotalProvider);
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly budget',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (budget == null)
              const Text('No budget set')
            else ...[
              Text('${formatMoney(spent)} of ${formatMoney(budget)}'),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (spent / budget).clamp(0.0, 1.0),
                color: spent > budget ? colors.error : colors.primary,
              ),
            ],
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _editBudget(context, ref),
                child: Text(budget == null ? 'Set budget' : 'Change'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetDialog extends StatefulWidget {
  const _BudgetDialog({this.initial});

  final int? initial;

  @override
  State<_BudgetDialog> createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<_BudgetDialog> {
  late final _controller = TextEditingController(
    text: switch (widget.initial) {
      final value? => (value / 100).toStringAsFixed(2),
      null => '',
    },
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Monthly budget'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(prefixText: '₦ ', hintText: '0.00'),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final amount = double.tryParse(_controller.text) ?? 0;
            Navigator.pop(context, (amount * 100).round());
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
