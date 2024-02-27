import 'package:shamsi_date/shamsi_date.dart';

extension DateTimeFormatExtension on Date {
  String toPersianDateTimeFormat() {
    final f = formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy} ${'ساعت'} ${hour.toString().padLeft(2, '0')}${':'}${minute.toString().padLeft(2, '0')}';
  }
}