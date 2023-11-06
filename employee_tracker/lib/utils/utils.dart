import 'package:employee_tracker/utils/constants.dart';
import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime) {
  return DateFormat(dateFormat).format(dateTime);
}

String getDateForSelectedEnum(DateSelection selectedDate) {
  String selectedDateString = '';
  switch (selectedDate) {
    case DateSelection.today:
      selectedDateString = getFormattedDateTime(DateTime.now());
      break;
    case DateSelection.nextMonday:
      selectedDateString =
          getFormattedDateTime(DateTime.now().next(DateTime.monday));
      break;
    case DateSelection.nextTuesday:
      selectedDateString =
          getFormattedDateTime(DateTime.now().next(DateTime.tuesday));
      break;
    case DateSelection.after1Week:
      selectedDateString =
          getFormattedDateTime(DateTime.now().next(DateTime.now().weekday));
      break;
    default:
      selectedDateString = 'No date';
  }
  return selectedDateString;
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    if (day == weekday) {
      return add(const Duration(days: 7));
    } else {
      return add(
        Duration(
          days: (day - weekday) % DateTime.daysPerWeek,
        ),
      );
    }
  }
}
