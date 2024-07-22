import 'package:flutter/material.dart';

class EmployeeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? textButton;

  const EmployeeButton({
    super.key,
    required this.onTap,
    this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text((textButton??'Save').toUpperCase()),
    );
  }
}
