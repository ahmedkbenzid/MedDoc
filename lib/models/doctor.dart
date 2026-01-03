class Doctor {
  final String id;
  String name;
  String category;
  List<String> services;          // Liste modifiable des services
  Map<String, String> workingHours; // Horaires modifiables

  Doctor({
    required this.id,
    required this.name,
    required this.category,
    List<String>? services,
    Map<String, String>? workingHours,
  })  : services = services ?? [],
        workingHours = workingHours ?? {};
}
