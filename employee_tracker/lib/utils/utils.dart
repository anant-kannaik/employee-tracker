import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

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

String getDateForEmployee(Employee employee) {
  if (employee.toDate == noDateHintText) {
    return 'From ${employee.fromDate}';
  }
  return '${employee.fromDate} - ${employee.toDate}';
}

bool checkIfDatesValid(String fromDate, String toDate) {
  DateTime convertedFromDate = DateFormat(dateFormat).parse(fromDate);
  DateTime convertedToDate = DateFormat(dateFormat).parse(toDate);
  if (convertedFromDate.isAfter(convertedToDate)) {
    return false;
  }
  return true;
}
