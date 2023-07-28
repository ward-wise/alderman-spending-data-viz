import 'package:alderman_spending/src/data/models/annual_ward_spending_data.dart';
import 'package:alderman_spending/src/data/models/ward_item_location_spending_data.dart';
import 'package:alderman_spending/src/utils/csv_service.dart';

Future<List<AnnualWardSpendingData>> loadAnnualCategorySpendingData() async {
  final csvTable = await readCSV('assets/2019-2022_ward_category_totals.csv');
  if (csvTable.isEmpty) {
    return [];
  }
  List<AnnualWardSpendingData> spendingData = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    final newData = AnnualWardSpendingData(
      ward: int.parse(item[0].trim()),
      year: int.parse(item[1].trim()),
      category: item[2].trim(),
      cost: int.parse(item[3].trim()),
    );
    spendingData.add(newData);
  }
  return spendingData;
}

Future<List<WardItemLocationSpendingData>> loadCategoryItemsData() async {
  final csvTable = await readCSV('assets/2019-2022_ward_items.csv');
  if (csvTable.isEmpty) {
    return [];
  }
  List<WardItemLocationSpendingData> itemData = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    final newData = WardItemLocationSpendingData(
      ward: int.parse(item[0].trim()),
      year: int.parse(item[1].trim()),
      item: item[2].trim(),
      category: item[3].trim(),
      location: item[4].trim(),
      cost: int.parse(item[5].trim()),
    );
    itemData.add(newData);
  }
  return itemData;
}
