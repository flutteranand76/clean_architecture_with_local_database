import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:demo/feature/employee/domain/repository/employee_repository.dart';

class UpdateEmployee {
  final EmployeeRepository employeeRepository;

  UpdateEmployee(this.employeeRepository);

  Future<void> call(Employee e) async {
    await employeeRepository.updateEmployee(
      id: e.id,
      name: e.name,
      email: e.email,
      phone: e.phone,
      isActive: e.isActive ?? true,
      profile: e.profile ?? "",
    );
  }
}
