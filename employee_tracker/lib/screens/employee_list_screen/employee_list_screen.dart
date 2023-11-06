import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_bloc.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_event.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_state.dart';
import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/utils/app_colors.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:employee_tracker/widgets/employee_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final List<Employee> _currentEmployees = [];
  final List<Employee> _previousEmployees = [];
  late EmployeeListScreenBloc _employeeListScreenBloc;

  @override
  void initState() {
    _employeeListScreenBloc = BlocProvider.of<EmployeeListScreenBloc>(context);
    _employeeListScreenBloc.add(FetchEmployeeListEvent());
    super.initState();
  }

  @override
  void dispose() {
    _employeeListScreenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(employeeListScreenTitle),
      ),
      body: BlocListener<EmployeeListScreenBloc, EmployeeListScreenState>(
        listener: (BuildContext context, state) {
          if (state is EmployeeListScreenFetchedState) {
            setState(() {
              _currentEmployees.clear();
              _previousEmployees.clear();
              _currentEmployees.addAll(state.currentEmployees);
              _previousEmployees.addAll(state.previousEmployees);
            });
          }
        },
        child: SafeArea(
          child: _getEmployeeListView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, addEmployeeDetailsScreenRouteName);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  _getEmployeeListView() {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text(
                'Current Employees',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              _getCurrentEmployees(),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text(
                'Previous Employees',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              _getPreviousEmployees(),
            ],
          ),
        ),
      ],
    );
  }

  _getCurrentEmployees() {
    return _currentEmployees.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _currentEmployees.length,
            itemBuilder: (BuildContext context, int index) {
              return EmployeeListItem(
                employee: _currentEmployees[index],
                onItemTap: (trip) {},
              );
            },
          )
        : Center(
            child: Image.asset(
              noEmployeeImageName,
              height: 220.0,
            ),
          );
  }

  _getPreviousEmployees() {
    return _previousEmployees.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _previousEmployees.length,
            itemBuilder: (BuildContext context, int index) {
              return EmployeeListItem(
                employee: _previousEmployees[index],
                onItemTap: (trip) {},
              );
            },
          )
        : Center(
            child: Image.asset(
              noEmployeeImageName,
              height: 220.0,
            ),
          );
  }
}
