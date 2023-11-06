import 'package:employee_tracker/utils/constants.dart';
import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime) {
  return DateFormat(dateFormat).format(dateTime);
}
