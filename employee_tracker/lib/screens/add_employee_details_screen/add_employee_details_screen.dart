import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_bloc.dart';
import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_event.dart';
import 'package:employee_tracker/utils/app_colors.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:employee_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEmployeeDetailsScreen extends StatefulWidget {
  const AddEmployeeDetailsScreen({super.key});

  @override
  State<AddEmployeeDetailsScreen> createState() =>
      _AddEmployeeDetailsScreenState();
}

class _AddEmployeeDetailsScreenState extends State<AddEmployeeDetailsScreen> {
  final employeeNameController = TextEditingController();
  String? _selectedRole;
  String _selectedFromDate = todayDateHintText;
  String _selectedToDate = noDateHintText;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    employeeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(addEmployeeDetailsScreenTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: employeeNameController,
                  cursorColor: AppColors.primaryColor,
                  decoration: const InputDecoration(
                    labelText: employeeNameHintText,
                    labelStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black38,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              DropdownMenu<String>(
                width: MediaQuery.of(context).size.width * 0.90,
                label: const Text(selectRoleHintText),
                onSelected: (String? value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
                dropdownMenuEntries:
                    roleTypes.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _showDateTimePickerDialog(
                                    true, DateSelection.today);
                              },
                              iconSize: 30.0,
                              icon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              _selectedFromDate,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColor,
                        size: 20.0,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _showDateTimePickerDialog(
                                    false, DateSelection.noDate);
                              },
                              iconSize: 30.0,
                              icon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              _selectedToDate,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffEDF8FF)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(cancelButtonText),
                        ),
                        const SizedBox(width: 10.0),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                          ),
                          onPressed: () {
                            BlocProvider.of<AddEmployeeDetailsScreenBloc>(
                                    context)
                                .add(InsertEmployeeEvent(
                                    name: employeeNameController.text.trim(),
                                    role: _selectedRole!,
                                    fromDate: _selectedFromDate,
                                    toDate: _selectedToDate));
                          },
                          child: const Text(saveButtonText),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDateTimePickerDialog(bool isFromDate, DateSelection preSelectedDate) {
    DateSelection selectedButton = preSelectedDate;
    String selectedDate = '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isFromDate) ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  selectedButton == DateSelection.today
                                      ? AppColors.primaryColor
                                      : const Color(0xffEDF8FF),
                              foregroundColor:
                                  selectedButton == DateSelection.today
                                      ? const Color(0xffEDF8FF)
                                      : AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedButton = DateSelection.today;
                              });
                            },
                            child: const Text('Today'),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  selectedButton == DateSelection.nextMonday
                                      ? AppColors.primaryColor
                                      : const Color(0xffEDF8FF),
                              foregroundColor:
                                  selectedButton == DateSelection.nextMonday
                                      ? const Color(0xffEDF8FF)
                                      : AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedButton = DateSelection.nextMonday;
                              });
                            },
                            child: const Text('Next Monday'),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  selectedButton == DateSelection.nextTuesday
                                      ? AppColors.primaryColor
                                      : const Color(0xffEDF8FF),
                              foregroundColor:
                                  selectedButton == DateSelection.nextTuesday
                                      ? const Color(0xffEDF8FF)
                                      : AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedButton = DateSelection.nextTuesday;
                              });
                            },
                            child: const Text('Next Tuesday'),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  selectedButton == DateSelection.after1Week
                                      ? AppColors.primaryColor
                                      : const Color(0xffEDF8FF),
                              foregroundColor:
                                  selectedButton == DateSelection.after1Week
                                      ? const Color(0xffEDF8FF)
                                      : AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedButton = DateSelection.after1Week;
                              });
                            },
                            child: const Text('After 1 week'),
                          ),
                        )
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  selectedButton == DateSelection.noDate
                                      ? AppColors.primaryColor
                                      : const Color(0xffEDF8FF),
                              foregroundColor:
                                  selectedButton == DateSelection.noDate
                                      ? const Color(0xffEDF8FF)
                                      : AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedButton = DateSelection.noDate;
                              });
                            },
                            child: const Text('No date'),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  selectedButton == DateSelection.today
                                      ? AppColors.primaryColor
                                      : const Color(0xffEDF8FF),
                              foregroundColor:
                                  selectedButton == DateSelection.today
                                      ? const Color(0xffEDF8FF)
                                      : AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedButton = DateSelection.today;
                              });
                            },
                            child: const Text('Today'),
                          ),
                        )
                      ],
                    ),
                  ],
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                    child: SfDateRangePicker(
                      onSelectionChanged:
                          (dateRangePickerSelectionChangedArgs) {
                        setState(() {
                          selectedDate = getFormattedDateTime(
                              dateRangePickerSelectionChangedArgs.value);
                        });
                      },
                      selectionMode: DateRangePickerSelectionMode.single,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: AppColors.primaryColor,
                          size: 20.0,
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          child: Text(
                            selectedDate,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffEDF8FF)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(cancelButtonText),
                        ),
                        const SizedBox(width: 10.0),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                          ),
                          onPressed: () {
                            _onDateSelectionChanged(isFromDate, selectedDate);
                            Navigator.pop(context);
                          },
                          child: const Text(saveButtonText),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onDateSelectionChanged(bool isFromDate, String selectedDate) {
    setState(() {
      if (isFromDate) {
        _selectedFromDate = selectedDate;
      } else {
        _selectedToDate = selectedDate;
      }
    });
  }
}
