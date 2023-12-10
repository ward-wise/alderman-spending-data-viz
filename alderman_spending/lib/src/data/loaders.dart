import 'package:alderman_spending/src/data/models/annual_ward_spending_data.dart';
import 'package:alderman_spending/src/data/models/ward_item_location_spending_data.dart';
import 'package:alderman_spending/src/data/models/menu_item_info.dart';
import 'package:alderman_spending/src/data/models/viaduct_info.dart';
import 'package:alderman_spending/src/data/models/ward_info.dart';
import 'package:alderman_spending/src/services/csv_service.dart';
import 'dart:convert';

Future<List<AnnualWardSpendingData>> loadAnnualCategorySpendingData() async {
  final csvTable = await readCSV('assets/2012-2023_ward_category_totals.csv');
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
  final csvTable = await readCSV('assets/2012-2023_ward_items.csv');
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

Future<List<MenuItemInfo>> loadMenuItems() async {
  final csvTable = await readCSV('assets/menu_items_info.csv');
  if (csvTable.isEmpty) {
    return [];
  }

  List<MenuItemInfo> menuItems = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    // Parse the 'Notes' column as JSON
    List<String>? notes = [];
    try {
      notes = List<String>.from(json.decode(item[4].trim()));
    } catch (e) {
      notes = null;
    }

    final newData = MenuItemInfo(
      title: item[0].trim(),
      cost: int.parse(item[1].trim()),
      measurement: item[2].trim(),
      description: item[3].trim(),
      notes: notes,
      visionZero: item[5].trim() == 'True',
      imgFilename: item[6].trim(),
    );
    menuItems.add(newData);
  }
  return menuItems;
}

Future<List<ViaductImprovementInfo>> loadViaductImprovements() async {
  final csvTable = await readCSV('assets/viaduct_improvements.csv');
  if (csvTable.isEmpty) {
    return [];
  }

  List<ViaductImprovementInfo> improvements = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    final newData = ViaductImprovementInfo(
      name: item[0].trim(),
      cost: int.parse(item[1].trim()),
      measurement: item[2].trim(),
      description: item[3].trim(),
    );
    improvements.add(newData);
  }
  return improvements;
}

Future<List<WardInformation>> loadWardsInformation() async {
  final csvTable = await readCSV('assets/ward_contact_info.csv');
  if (csvTable.isEmpty) {
    return [];
  }
  List<WardInformation> wardInfo = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];

    Map<String, String>? wardWebsites;

    if (item[5] != null && item[5].trim().isNotEmpty) {
      wardWebsites = {};
      String rawWebsitesString =
          item[5].replaceAll("{", "").replaceAll("}", "");
      List<String> websitesPairs = rawWebsitesString.trim().split(",");
      for (var pair in websitesPairs) {
        List<String> pairSplit = pair.split(": ");
        String key = pairSplit[0].trim();
        String value = pairSplit[1].trim();

        // Check if the URL starts with "https://" or "http://"
        if (!value.startsWith("http://") && !value.startsWith("https://")) {
          // If not, prepend "https://"
          value = "https://$value";
        }

        wardWebsites.addAll({key: value});
      }
    }
    final newData = WardInformation(
      wardNumber: int.parse(item[0].trim()),
      alderpersonName: item[1].trim(),
      wardAddress: item[2].trim(),
      wardEmail: item[3].trim(),
      wardPhone: item[4].trim(),
      wardWebsites: wardWebsites,
    );
    wardInfo.add(newData);
  }
  return wardInfo;
}
