import 'package:demo/feature/employee/domain/repository/employee_repository.dart';

import 'package:demo/feature/employee/domain/entities/employee.dart';

class AddEmployees {
  final EmployeeRepository employeeRepository;

  AddEmployees(this.employeeRepository);

  Future<void> call(Employee e) async {
    await employeeRepository.addEmployee(
        id: e.id,
        name: e.name,
        email: e.email,
        phone: e.phone,
        isActive: e.isActive ?? true,
        profile: e.profile ?? "");
  }
}
