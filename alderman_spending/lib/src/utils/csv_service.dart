import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

readCSV(path) async {
  late String rawData;
  try {
    rawData = await rootBundle.loadString(path);
  } catch (e) {
    return [];
  }
  final csvTable = const CsvToListConverter().convert(
    rawData,
    eol: '\n',
    shouldParseNumbers: false,
  );
  return csvTable;
}
