const appNameText = 'Employee Tracker';

const employeeListScreenRouteName = '/EmployeeList';
const addEmployeeDetailsScreenRouteName = '/AddEmployeeDetails';

const employeeKey = 'employee';
const isCurrentEmployeeKey = 'isCurrentEmployee';
const employeeListScreenBlocKey = 'employeeListScreenBloc';

const employeeListScreenTitle = 'Employee List';
const addEmployeeDetailsScreenTitle = 'Add Employee Details';
const editEmployeeDetailsScreenTitle = 'Edit Employee Details';

const noEmployeeImageName = 'assets/no_employee_image.png';

const employeeNameHintText = 'Employee Name';
const selectRoleHintText = 'Select Role';

const todayDateHintText = 'Today';
const noDateHintText = 'No date';

const cancelButtonText = 'Cancel';
const saveButtonText = 'Save';

const List<String> roleTypes = [
  'Product Designer',
  'Flutter Developer',
  'QA Tester',
  'Product Owner'
];

const dateFormat = 'dd MMM y';

enum DateSelection { today, nextMonday, nextTuesday, after1Week, noDate, empty }
