import 'package:employee_tracker/models/employee.dart';

abstract class EmployeeListScreenState {}

class EmployeeListScreenInitialState extends EmployeeListScreenState {}

class EmployeeListScreenLoadingState extends EmployeeListScreenState {}

class EmployeeListScreenFetchedState extends EmployeeListScreenState {
  final List<Employee> employees;

  EmployeeListScreenFetchedState({required this.employees});
}
