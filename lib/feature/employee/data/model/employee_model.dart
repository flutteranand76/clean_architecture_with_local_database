import 'package:demo/feature/employee/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  EmployeeModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    super.isActive,
    super.profile,
  });

  factory EmployeeModel.fromJson(Map<dynamic, dynamic> map) {
    return EmployeeModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        isActive: map['isActive'],
        profile: map['profile']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isActive': isActive,
      'profile': profile,
    };
  }

  static EmployeeModel empty() {
    return EmployeeModel(
      id: "",
      name: "",
      email: "",
      phone: "",
    );
  }

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    bool? isActive,
    String? profile,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      profile: profile ?? this.profile,
    );
  }
}
