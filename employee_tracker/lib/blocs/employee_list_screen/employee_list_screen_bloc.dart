import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_event.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_state.dart';
import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/repository/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreenBloc
    extends Bloc<EmployeeListScreenEvent, EmployeeListScreenState> {
  EmployeeListScreenBloc() : super(EmployeeListScreenInitialState()) {
    on<FetchEmployeeListEvent>(_handleFetchEmployeeList);
  }

  void _handleFetchEmployeeList(FetchEmployeeListEvent event,
      Emitter<EmployeeListScreenState> emit) async {
    emit(EmployeeListScreenLoadingState());

    List<Employee> currentEmployees =
        await DatabaseHelper.sharedInstance.getCurrentEmployees();

    List<Employee> previousEmployees =
        await DatabaseHelper.sharedInstance.getPreviousEmployees();

    emit(EmployeeListScreenFetchedState(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees));
  }
}
