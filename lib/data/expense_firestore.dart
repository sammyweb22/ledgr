import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ledgr_core/ledgr_core.dart';

Map<String, dynamic> expenseToFirestore(Expense expense) => {
  'title': expense.title,
  'amountCents': expense.amountCents,
  'category': expense.category.name,
  'date': Timestamp.fromDate(expense.date),
};

Expense expenseFromFirestore(String id, Map<String, dynamic> data) => Expense(
  id: id,
  title: data['title'] as String,
  amountCents: data['amountCents'] as int,
  category: Category.values.byName(data['category'] as String),
  date: (data['date'] as Timestamp).toDate(),
);
