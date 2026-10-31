import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:ledgr_core/ledgr_core.dart';

part 'app_database.g.dart';

class ExpenseRows extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get amountCents => integer()();
  TextColumn get category => textEnum<Category>()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [ExpenseRows])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'ledgr'));

  @override
  int get schemaVersion => 1;
}

extension ExpenseRowToExpense on ExpenseRow {
  Expense toExpense() => Expense(
    id: id,
    title: title,
    amountCents: amountCents,
    category: category,
    date: date,
  );
}

extension ExpenseToRow on Expense {
  ExpenseRowsCompanion toRow() => ExpenseRowsCompanion.insert(
    id: id,
    title: title,
    amountCents: amountCents,
    category: category,
    date: date,
  );
}
