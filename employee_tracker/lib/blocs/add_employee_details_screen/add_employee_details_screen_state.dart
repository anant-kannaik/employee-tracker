import 'package:employee_tracker/models/employee.dart';

abstract class AddEmployeeDetailsScreenState {}

class AddEmployeeDetailsScreenInitialState
    extends AddEmployeeDetailsScreenState {}

class AddEmployeeDetailsScreenInsertedState
    extends AddEmployeeDetailsScreenState {
  final Employee employee;

  AddEmployeeDetailsScreenInsertedState({required this.employee});
}

class AddEmployeeDetailsScreenUpdatedState
    extends AddEmployeeDetailsScreenState {
  final Employee employee;

  AddEmployeeDetailsScreenUpdatedState({required this.employee});
}
