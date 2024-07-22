part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

final class AddEmployee extends EmployeeEvent {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool? isActive;
  final String? profile;

  AddEmployee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.isActive,
    this.profile,
  });
}

final class EmployeeUpdateSuccessEvent extends EmployeeEvent {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool? isActive;
  final String? profile;

  EmployeeUpdateSuccessEvent({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.isActive,
    this.profile,
  });
}

final class GetAllEmployee extends EmployeeEvent {}

final class DeleteEmployeeEvent extends EmployeeEvent {
  final String id;

  DeleteEmployeeEvent(this.id);
}

final class ProfileAddSuccessEvent extends EmployeeEvent {
  final String profilePath;

  ProfileAddSuccessEvent(this.profilePath);
}
