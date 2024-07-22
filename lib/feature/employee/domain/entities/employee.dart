class Employee {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool? isActive;
  final String? profile;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.isActive,
    this.profile,
  });
}
