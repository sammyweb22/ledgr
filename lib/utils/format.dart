import 'package:intl/intl.dart';

final _money = NumberFormat.currency(locale: 'en', symbol: '₦');
final _date = DateFormat('d MMM yyyy');

String formatMoney(int minorUnits) => _money.format(minorUnits / 100);

String formatDate(DateTime date) => _date.format(date);
