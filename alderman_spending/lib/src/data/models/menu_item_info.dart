class MenuItemInfo {
  final String title;
  final int cost;
  final String measurement;
  final String description;
  final List<String>? notes;
  final bool visionZero;
  final String imgFilename;

  MenuItemInfo({
    required this.title,
    required this.cost,
    required this.measurement,
    required this.description,
    this.notes,
    required this.visionZero,
    required this.imgFilename,
  });
}
