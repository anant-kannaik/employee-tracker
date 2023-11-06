import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/repository/database_helper.dart';
import 'package:employee_tracker/utils/app_colors.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEmployeeDetailsScreen extends StatefulWidget {
  const AddEmployeeDetailsScreen({super.key});

  @override
  State<AddEmployeeDetailsScreen> createState() =>
      _AddEmployeeDetailsScreenState();
}

class _AddEmployeeDetailsScreenState extends State<AddEmployeeDetailsScreen> {
  final employeeNameController = TextEditingController();

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
                // initialSelection: _selectedBike,
                onSelected: (String? value) {
                  setState(() {
                    // _selectedBike = value!;
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
                                _showDateTimePickerDialog();
                              },
                              iconSize: 30.0,
                              icon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const Text(
                              todayDateHintText,
                              maxLines: 1,
                              style: TextStyle(
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
                                _showDateTimePickerDialog();
                              },
                              iconSize: 30.0,
                              icon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const Text(
                              noDateHintText,
                              maxLines: 1,
                              style: TextStyle(
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
                          onPressed: () async {
                            var employee = Employee(
                                id: 1,
                                name: 'Anant',
                                role: 'Flutter Developer',
                                fromDate: '10-1-2023',
                                toDate: '31-8-2023');

                            await DatabaseHelper.sharedInstance
                                .insertEmployee(employee);
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

  _showDateTimePickerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffEDF8FF)),
                      ),
                      onPressed: () {},
                      child: const Text('Today'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor),
                      ),
                      onPressed: () {},
                      child: const Text('Next Monday'),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffEDF8FF)),
                      ),
                      onPressed: () {},
                      child: const Text('Next Tuesday'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor),
                      ),
                      onPressed: () {},
                      child: const Text('After 1 week'),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 300.0,
                height: 300.0,
                child: SfDateRangePicker(
                  onSelectionChanged: (dateRangePickerSelectionChangedArgs) {},
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
                    const Expanded(
                      child: Text(
                        noDateHintText,
                        maxLines: 1,
                        style: TextStyle(
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
                      onPressed: () {},
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
  }
}
