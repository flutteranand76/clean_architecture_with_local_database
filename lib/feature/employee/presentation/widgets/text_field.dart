import 'package:flutter/material.dart';

class EmployeeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final int? maxLength;
  final TextInputType? textInputType;

  const EmployeeTextField({
    super.key,
    required this.controller,
    this.hint,
    this.maxLength,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hint,
        counter: const SizedBox.shrink(),
      ),
      maxLength: maxLength,
      validator: (v) {
        if (v?.isEmpty ?? false) {
          return "$hint is require";
        }
        return null;
      },
    );
  }
}
