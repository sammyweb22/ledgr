import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ledgr_core/ledgr_core.dart';

import '../providers/expenses_provider.dart';
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
      body: total == 0
          ? const Center(child: Text('No expenses yet'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
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
            ),
    );
  }
}
