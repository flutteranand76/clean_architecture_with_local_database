import 'package:demo/core/utils/get_random_string.dart';
import 'package:demo/feature/employee/data/model/employee_model.dart';
import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:hive/hive.dart';

abstract interface class EmployeeLocalDataSource {
  void addNewEmployee({required EmployeeModel employee});

  List<EmployeeModel> getAllEmployee();

  void deleteEmployee(String id);

  void updateEmployee({required EmployeeModel employee});
}

class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  final Box box;

  EmployeeLocalDataSourceImpl(this.box);

  @override
  void addNewEmployee({required EmployeeModel employee}) {
    // String id = getRandomString();
    box.put(employee.id,employee.toJson());
  }

  @override
  List<EmployeeModel> getAllEmployee() {
    List<EmployeeModel> list = [];
    for (int i = 0; i < box.length; i++) {
      list.add(EmployeeModel.fromJson(box.getAt(i)));
    }
    return list;
  }

  @override
  void deleteEmployee(String id) {
    box.delete(id);
  }

  @override
  void updateEmployee({
    required EmployeeModel employee,
  }) {
    box.delete(employee.id);
    box.put(employee.id, employee.toJson());
  }
}
