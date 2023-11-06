abstract class AddEmployeeDetailsScreenEvent {}

class InsertEmployeeEvent extends AddEmployeeDetailsScreenEvent {
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  InsertEmployeeEvent(
      {required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});
}
