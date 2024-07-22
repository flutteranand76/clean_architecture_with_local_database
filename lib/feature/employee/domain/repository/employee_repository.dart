import 'package:demo/feature/employee/domain/entities/employee.dart';

abstract interface class EmployeeRepository {
  Future<void> addEmployee({
    required String id,
    required String name,
    required String email,
    required String phone,
    bool isActive,
    String profile,
  });

  Future<List<Employee>> getAllEmployee();

  Future<void> deleteEmployee({required String id});

  Future<void> updateEmployee({
    required String id,
    required String name,
    required String email,
    required String phone,
    bool isActive,
    String profile,
  });
}
