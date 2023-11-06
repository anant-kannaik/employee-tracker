import 'package:employee_tracker/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final Function(Employee employee) onItemTap;

  const EmployeeListItem(
      {super.key, required this.employee, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  employee.role,
                  style: const TextStyle(
                    fontSize: 12.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  employee.fromDate,
                  style: const TextStyle(
                    fontSize: 12.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        onItemTap(employee);
      },
    );
  }
}
