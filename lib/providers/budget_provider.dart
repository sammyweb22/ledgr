import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_provider.dart';

final budgetProvider = NotifierProvider<BudgetNotifier, int?>(
  BudgetNotifier.new,
);

class BudgetNotifier extends Notifier<int?> {
  static const _key = 'monthly_budget';

  @override
  int? build() => ref.watch(sharedPreferencesProvider).getInt(_key);

  void setBudget(int? minorUnits) {
    state = minorUnits;
    final prefs = ref.read(sharedPreferencesProvider);
    if (minorUnits == null) {
      prefs.remove(_key);
    } else {
      prefs.setInt(_key, minorUnits);
    }
  }
}
