import 'package:demo/feature/employee/data/data_source/employee_local_data_source.dart';
import 'package:demo/feature/employee/data/model/employee_model.dart';
import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:demo/feature/employee/domain/repository/employee_repository.dart';
import 'package:flutter/material.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeLocalDataSource employeeLocalDataSource;

  EmployeeRepositoryImpl(this.employeeLocalDataSource);

  @override
  Future<void> addEmployee({
    required String id,
    required String name,
    required String email,
    required String phone,
    bool? isActive,
    String? profile,
  }) async {
    try {
      employeeLocalDataSource.addNewEmployee(
          employee: EmployeeModel(
        id: id,
        name: name,
        email: email,
        phone: phone,
        isActive: isActive ?? true,
        profile: profile ?? "",
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<List<Employee>> getAllEmployee() async {
    List<Employee> list = [];
    try {
      final employee = employeeLocalDataSource.getAllEmployee();
      list.addAll(employee);
      return list;
    } catch (e) {
      debugPrint(e.toString());
      return list;
    }
  }

  @override
  Future<void> deleteEmployee({required String id}) async {
    try {
      employeeLocalDataSource.deleteEmployee(id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> updateEmployee({
    required String id,
    required String name,
    required String email,
    required String phone,
    bool? isActive,
    String? profile,
  }) async{
    try {
      employeeLocalDataSource.updateEmployee(
          employee: EmployeeModel(
            id: id,
            name: name,
            email: email,
            phone: phone,
            isActive: isActive,
            profile: profile,
          ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
