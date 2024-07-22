import 'package:demo/core/utils/show_snackbar.dart';
import 'package:demo/feature/employee/data/model/employee_model.dart';
import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:demo/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:demo/feature/employee/presentation/widgets/employee_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_employee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(GetAllEmployee());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEmployeePage(
                              employee: EmployeeModel.empty(),
                            ))).then((value) =>
                    context.read<EmployeeBloc>().add(GetAllEmployee()));
              },
              icon: const Icon(Icons.add_circle_outline))
        ],
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is EmployeeDisplaySuccess) {
            return ListView.builder(
              itemCount: state.employee.length,
              itemBuilder: (context, index) {
                Employee emp = state.employee[index];
                return EmployeeTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEmployeePage(employee: emp)));
                        // .then(
                        //     (_){
                        //       context.read<EmployeeBloc>().add(GetAllEmployee())
                        //     });
                  },
                  employee: emp,
                );
              },
            );
          } else if (state is EmployeeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
