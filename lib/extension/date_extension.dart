import 'package:intl/intl.dart';

extension FormatDateExtension on DateTime {
  String formatDate() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
