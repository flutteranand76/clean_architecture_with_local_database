import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:demo/feature/employee/domain/use_cases/add_employee.dart';
import 'package:demo/feature/employee/domain/use_cases/delete_employee.dart';
import 'package:demo/feature/employee/domain/use_cases/get_amployees.dart';
import 'package:demo/feature/employee/domain/use_cases/update_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_event.dart';

part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final AddEmployees _addEmployee;
  final GetEmployees _getEmployees;
  final DeleteEmployee _deleteEmployee;
  final UpdateEmployee _updateEmployee;

  EmployeeBloc({
    required AddEmployees addEmployee,
    required GetEmployees getEmployee,
    required DeleteEmployee deleteEmployee,
    required UpdateEmployee updateEmployee,
  })  : _addEmployee = addEmployee,
        _getEmployees = getEmployee,
        _deleteEmployee = deleteEmployee,
        _updateEmployee = updateEmployee,
        super(EmployeeInitial()) {
    on<EmployeeEvent>((event, emit) {
      emit(EmployeeLoading());
    });
    on<AddEmployee>(_onAddEmployee);
    on<GetAllEmployee>(_onGetEmployeeList);
    on<DeleteEmployeeEvent>(_onDeleteEmployee);
    on<ProfileAddSuccessEvent>(_onAddProfilePic);
    on<EmployeeUpdateSuccessEvent>(_onUpdateEmployee);
  }

  void _onAddEmployee(AddEmployee event, Emitter<EmployeeState> emit) async {
    await _addEmployee(Employee(
      id: event.id,
      email: event.email,
      name: event.name,
      phone: event.phone,
      isActive: event.isActive,
      profile: event.profile,
    ));

    emit(EmployeeAddSuccess());
  }

  void _onUpdateEmployee(
      EmployeeUpdateSuccessEvent event, Emitter<EmployeeState> emit) async {
    await _updateEmployee(Employee(
      id: event.id,
      email: event.email,
      name: event.name,
      phone: event.phone,
      isActive: event.isActive,
      profile: event.profile,
    ));

    emit(EmployeeUpdateSuccess());
  }

  void _onGetEmployeeList(
      GetAllEmployee event, Emitter<EmployeeState> emit) async {
    var res = await _getEmployees();
    if (res != null) {
      emit(EmployeeDisplaySuccess(res));
    } else {
      emit(
        EmployeeFailure('Something wrong'),
      );
    }
  }

  void _onDeleteEmployee(
      DeleteEmployeeEvent event, Emitter<EmployeeState> emit) async {
    _deleteEmployee(event.id);
  }

  void _onAddProfilePic(
      ProfileAddSuccessEvent event, Emitter<EmployeeState> emit) async {
    emit(ProfileAddSuccess());
  }
}
