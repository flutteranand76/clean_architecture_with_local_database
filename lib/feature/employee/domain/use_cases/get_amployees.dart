import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:demo/feature/employee/domain/repository/employee_repository.dart';

class GetEmployees {
  final EmployeeRepository employeeRepository;

  GetEmployees(this.employeeRepository);

  Future<List<Employee>> call()async{
    return await employeeRepository.getAllEmployee();
  }
}


class NoParams {}