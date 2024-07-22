import 'dart:io';

import 'package:demo/core/utils/get_random_string.dart';
import 'package:demo/core/utils/image_picker.dart';
import 'package:demo/core/utils/show_snackbar.dart';
import 'package:demo/feature/employee/domain/entities/employee.dart';
import 'package:demo/feature/employee/domain/use_cases/update_employee.dart';
import 'package:demo/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:demo/feature/employee/presentation/widgets/button.dart';
import 'package:demo/feature/employee/presentation/widgets/text_field.dart';
import 'package:demo/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeePage extends StatefulWidget {
  final Employee employee;

  const AddEmployeePage({
    super.key,
    required this.employee,
  });

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectedImagePath;
  IsActive isActive = IsActive.yes;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.employee.name;
    emailController.text = widget.employee.email;
    phoneController.text = widget.employee.phone;
    selectedImagePath = widget.employee.profile;
    isActive = widget.employee.isActive == false ? IsActive.no : IsActive.yes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeFailure) {
            showSnackBar(context, state.error);
          } else if (state is EmployeeAddSuccess) {
            Navigator.pop(context);
          }else if (state is EmployeeUpdateSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var img = await pickImage();
                        if (img != null) {
                          selectedImagePath = img.path;
                          serviceLocator.get<EmployeeBloc>().add(
                              ProfileAddSuccessEvent(selectedImagePath ?? ""));
                        }
                      },
                      child: Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColorDark),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: Image.file(
                            File(selectedImagePath ?? ""),
                            fit: BoxFit.cover,
                            errorBuilder: (context, obj, _) {
                              return Image.network(
                                  "https://placehold.co/200x200.jpg");
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // name
                    EmployeeTextField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      hint: "Name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // email
                    EmployeeTextField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      hint: "Email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // phone
                    EmployeeTextField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      maxLength: 10,
                      hint: "Phone",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Current Employee"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              value: IsActive.yes,
                              groupValue: isActive,
                              title: Text(IsActive.yes.name),
                              onChanged: (v) {
                                isActive = IsActive.yes;
                                setState(() {});
                              }),
                        ),
                        Expanded(
                          child: RadioListTile(
                              value: IsActive.no,
                              groupValue: isActive,
                              title: Text(IsActive.no.name),
                              onChanged: (v) {
                                isActive = IsActive.no;
                                setState(() {});
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    EmployeeButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (widget.employee.id.isEmpty) {
                            context.read<EmployeeBloc>().add(
                                  AddEmployee(
                                      id: getRandomString(),
                                      email: emailController.text.trim(),
                                      name: nameController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      profile: selectedImagePath,
                                      isActive: isActive == IsActive.yes
                                          ? true
                                          : false),
                                );
                          } else {
                            context.read<EmployeeBloc>().add(
                                EmployeeUpdateSuccessEvent(
                                    id: widget.employee.id,
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    profile: selectedImagePath,
                                    isActive: isActive == IsActive.yes
                                        ? true
                                        : false));
                          }
                        }
                      },
                      textButton: "add",
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum IsActive { yes, no }
