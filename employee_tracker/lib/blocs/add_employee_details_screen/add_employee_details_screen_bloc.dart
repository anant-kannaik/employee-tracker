import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_event.dart';
import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_state.dart';
import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/repository/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeDetailsScreenBloc
    extends Bloc<AddEmployeeDetailsScreenEvent, AddEmployeeDetailsScreenState> {
  AddEmployeeDetailsScreenBloc()
      : super(AddEmployeeDetailsScreenInitialState()) {
    on<InsertEmployeeEvent>(_handleInsertEmployee);
  }

  void _handleInsertEmployee(InsertEmployeeEvent event,
      Emitter<AddEmployeeDetailsScreenState> emit) async {
    Employee employee = Employee(
        id: null, // Explicitly assigning a value of NULL to id, it will get the next auto-increment value.
        name: event.name,
        role: event.role,
        fromDate: event.fromDate,
        toDate: event.toDate);

    await DatabaseHelper.sharedInstance.insertEmployee(employee);

    emit(AddEmployeeDetailsScreenInsertedState(employee: employee));
  }
}
