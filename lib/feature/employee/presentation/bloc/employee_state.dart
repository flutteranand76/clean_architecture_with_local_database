part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeFailure extends EmployeeState {
  final String error;

  EmployeeFailure(this.error);
}

final class EmployeeAddSuccess extends EmployeeState {}

final class EmployeeUpdateSuccess extends EmployeeState{}

final class EmployeeDisplaySuccess extends EmployeeState {
  final List<Employee> employee;

  EmployeeDisplaySuccess(this.employee);
}

final class ProfileAddSuccess extends EmployeeState {}
