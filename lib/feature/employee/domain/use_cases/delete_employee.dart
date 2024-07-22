import 'package:demo/feature/employee/domain/repository/employee_repository.dart';

import 'package:demo/feature/employee/domain/entities/employee.dart';

class DeleteEmployee {
  final EmployeeRepository employeeRepository;

  DeleteEmployee(this.employeeRepository);

  Future<void> call(String id) async {
    await employeeRepository.deleteEmployee(id: id);

  }
}
