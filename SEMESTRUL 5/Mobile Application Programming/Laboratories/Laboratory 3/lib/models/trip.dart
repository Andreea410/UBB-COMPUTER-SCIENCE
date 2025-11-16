class Trip {
  final String id;
  String name;
  String destination;
  DateTime startDate;
  DateTime endDate;
  double totalBudget;
  String notes;

  Trip({
    required this.id,
    required this.name,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.totalBudget,
    required this.notes,
  });

  Trip copyWith({
    String? name,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    double? totalBudget,
    String? notes,
  }) {
    return Trip(
      id: id,
      name: name ?? this.name,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalBudget: totalBudget ?? this.totalBudget,
      notes: notes ?? this.notes,
    );
  }
}
