import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

readCSV(path, {String? eol = '\n'}) async {
  late String rawData;
  try {
    rawData = await rootBundle.loadString(path);
  } catch (e) {
    return [];
  }
  final csvTable = const CsvToListConverter().convert(
    rawData,
    eol: eol,
    shouldParseNumbers: false,
  );
  return csvTable;
}
