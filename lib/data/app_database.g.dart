// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ExpenseRowsTable extends ExpenseRows
    with TableInfo<$ExpenseRowsTable, ExpenseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Category, String> category =
      GeneratedColumn<String>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Category>($ExpenseRowsTable.$convertercategory);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    amountCents,
    category,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      category: $ExpenseRowsTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $ExpenseRowsTable createAlias(String alias) {
    return $ExpenseRowsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Category, String, String> $convertercategory =
      const EnumNameConverter<Category>(Category.values);
}

class ExpenseRow extends DataClass implements Insertable<ExpenseRow> {
  final String id;
  final String title;
  final int amountCents;
  final Category category;
  final DateTime date;
  const ExpenseRow({
    required this.id,
    required this.title,
    required this.amountCents,
    required this.category,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['amount_cents'] = Variable<int>(amountCents);
    {
      map['category'] = Variable<String>(
        $ExpenseRowsTable.$convertercategory.toSql(category),
      );
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  ExpenseRowsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseRowsCompanion(
      id: Value(id),
      title: Value(title),
      amountCents: Value(amountCents),
      category: Value(category),
      date: Value(date),
    );
  }

  factory ExpenseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      category: $ExpenseRowsTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'amountCents': serializer.toJson<int>(amountCents),
      'category': serializer.toJson<String>(
        $ExpenseRowsTable.$convertercategory.toJson(category),
      ),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  ExpenseRow copyWith({
    String? id,
    String? title,
    int? amountCents,
    Category? category,
    DateTime? date,
  }) => ExpenseRow(
    id: id ?? this.id,
    title: title ?? this.title,
    amountCents: amountCents ?? this.amountCents,
    category: category ?? this.category,
    date: date ?? this.date,
  );
  ExpenseRow copyWithCompanion(ExpenseRowsCompanion data) {
    return ExpenseRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      category: data.category.present ? data.category.value : this.category,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amountCents: $amountCents, ')
          ..write('category: $category, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, amountCents, category, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.amountCents == this.amountCents &&
          other.category == this.category &&
          other.date == this.date);
}

class ExpenseRowsCompanion extends UpdateCompanion<ExpenseRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> amountCents;
  final Value<Category> category;
  final Value<DateTime> date;
  final Value<int> rowid;
  const ExpenseRowsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseRowsCompanion.insert({
    required String id,
    required String title,
    required int amountCents,
    required Category category,
    required DateTime date,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       amountCents = Value(amountCents),
       category = Value(category),
       date = Value(date);
  static Insertable<ExpenseRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? amountCents,
    Expression<String>? category,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amountCents != null) 'amount_cents': amountCents,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? amountCents,
    Value<Category>? category,
    Value<DateTime>? date,
    Value<int>? rowid,
  }) {
    return ExpenseRowsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amountCents: amountCents ?? this.amountCents,
      category: category ?? this.category,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $ExpenseRowsTable.$convertercategory.toSql(category.value),
      );
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRowsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amountCents: $amountCents, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExpenseRowsTable expenseRows = $ExpenseRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [expenseRows];
}

typedef $$ExpenseRowsTableCreateCompanionBuilder =
    ExpenseRowsCompanion Function({
      required String id,
      required String title,
      required int amountCents,
      required Category category,
      required DateTime date,
      Value<int> rowid,
    });
typedef $$ExpenseRowsTableUpdateCompanionBuilder =
    ExpenseRowsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int> amountCents,
      Value<Category> category,
      Value<DateTime> date,
      Value<int> rowid,
    });

class $$ExpenseRowsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseRowsTable> {
  $$ExpenseRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Category, Category, String> get category =>
      $composableBuilder(
        column: $table.category,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseRowsTable> {
  $$ExpenseRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseRowsTable> {
  $$ExpenseRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Category, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$ExpenseRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseRowsTable,
          ExpenseRow,
          $$ExpenseRowsTableFilterComposer,
          $$ExpenseRowsTableOrderingComposer,
          $$ExpenseRowsTableAnnotationComposer,
          $$ExpenseRowsTableCreateCompanionBuilder,
          $$ExpenseRowsTableUpdateCompanionBuilder,
          (
            ExpenseRow,
            BaseReferences<_$AppDatabase, $ExpenseRowsTable, ExpenseRow>,
          ),
          ExpenseRow,
          PrefetchHooks Function()
        > {
  $$ExpenseRowsTableTableManager(_$AppDatabase db, $ExpenseRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<Category> category = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseRowsCompanion(
                id: id,
                title: title,
                amountCents: amountCents,
                category: category,
                date: date,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int amountCents,
                required Category category,
                required DateTime date,
                Value<int> rowid = const Value.absent(),
              }) => ExpenseRowsCompanion.insert(
                id: id,
                title: title,
                amountCents: amountCents,
                category: category,
                date: date,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpenseRowsTable, ExpenseRow>(table),
                  BaseReferences<_$AppDatabase, $ExpenseRowsTable, ExpenseRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseRowsTable,
      ExpenseRow,
      $$ExpenseRowsTableFilterComposer,
      $$ExpenseRowsTableOrderingComposer,
      $$ExpenseRowsTableAnnotationComposer,
      $$ExpenseRowsTableCreateCompanionBuilder,
      $$ExpenseRowsTableUpdateCompanionBuilder,
      (
        ExpenseRow,
        BaseReferences<_$AppDatabase, $ExpenseRowsTable, ExpenseRow>,
      ),
      ExpenseRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExpenseRowsTableTableManager get expenseRows =>
      $$ExpenseRowsTableTableManager(_db, _db.expenseRows);
}
