import 'dart:ui';

import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String get format => DateFormat('dd MMMM yyyy', Locale('es', 'ES').toString()).format(this);
}