class MenuItemInfo {
  final String title;
  final int cost;
  final String measurement;
  final String description;
  final List<String>? notes;

  MenuItemInfo({
    required this.title,
    required this.cost,
    required this.measurement,
    required this.description,
    this.notes,
  });
}
