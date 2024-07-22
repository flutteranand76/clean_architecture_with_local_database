import 'package:demo/feature/employee/data/data_source/employee_local_data_source.dart';
import 'package:demo/feature/employee/domain/repository/employee_repository.dart';
import 'package:demo/feature/employee/domain/use_cases/add_employee.dart';
import 'package:demo/feature/employee/domain/use_cases/delete_employee.dart';
import 'package:demo/feature/employee/domain/use_cases/get_amployees.dart';
import 'package:demo/feature/employee/domain/use_cases/update_employee.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'feature/employee/data/repository/employee_repository_impl.dart';
import 'feature/employee/presentation/bloc/employee_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initEmployees();

  // Hive.d = getApplicationDocumentsDirectory();
  var directoryPath = (await getApplicationDocumentsDirectory()).path;

  Hive.init(directoryPath);

  serviceLocator.registerLazySingleton(
    () => Hive.box("employees"),
  );

  await Hive.openBox('employees');
}

void _initEmployees() {
  // data source
  serviceLocator.registerFactory<EmployeeLocalDataSource>(
    () => EmployeeLocalDataSourceImpl(
      serviceLocator(),
    ),
  );

// Repository
  serviceLocator.registerFactory<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      serviceLocator(),
    ),
  );
// Use case
  serviceLocator.registerFactory(
    () => AddEmployees(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetEmployees(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => DeleteEmployee(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UpdateEmployee(
      serviceLocator(),
    ),
  );

  // Bloc
  serviceLocator.registerLazySingleton(
    () => EmployeeBloc(
      addEmployee: serviceLocator(),
      getEmployee: serviceLocator(),
      deleteEmployee: serviceLocator(),
      updateEmployee: serviceLocator(),
    ),
  );
}
