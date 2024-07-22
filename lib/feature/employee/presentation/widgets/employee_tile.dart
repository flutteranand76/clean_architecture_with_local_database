import 'dart:io';
import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:demo/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:demo/feature/employee/presentation/pages/add_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  final Function onTap;

  const EmployeeTile({
    super.key,
    required this.employee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      tileColor:
          employee.isActive == false ? Colors.red.withOpacity(0.4) : null,
      title: Text(employee.name),
      subtitle: Text(employee.email),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).primaryColorDark),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: Image.file(
            File(employee.profile ?? ""),
            fit: BoxFit.cover,
            errorBuilder: (context, obj, _) {
              return Image.network("https://placehold.co/200x200.jpg");
            },
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<EmployeeBloc>().add(DeleteEmployeeEvent(employee.id));
          context.read<EmployeeBloc>().add(GetAllEmployee());
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
