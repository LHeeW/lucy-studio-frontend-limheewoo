import 'package:edencrew_assignment_starter/models/realtime.dart';
import 'package:edencrew_assignment_starter/models/stock.dart';
import 'package:edencrew_assignment_starter/models/stock_metadata.dart';

bool isDomesticStock(Stock stock) {
  return stock.category == 'stock' &&
      stock.nationCode == 'KOR' &&
      RegExp(r'^\d{6}$').hasMatch(stock.code);
}

List<Stock> parseSearchResposne(dynamic data) {
  final Map<String, dynamic> json = data as Map<String, dynamic>;

  final List<dynamic> items = json['items'] as List<dynamic>;

  return items
      .map((item) => Stock.fromJson(item as Map<String, dynamic>))
      .where(isDomesticStock)
      .toList();
}

List<Realtime> parseRealtimeResponse(dynamic data) {
  final Map<String, dynamic> json = data as Map<String, dynamic>;

  final List<dynamic> datas =
      json['result']['areas'][0]['datas'] as List<dynamic>;

  return datas
      .map((data) => Realtime.fromJson(data as Map<String, dynamic>))
      .toList();
}

StockMetadata parseStockMetadataResponse(dynamic data) {
  final Map<String, dynamic> json = data as Map<String, dynamic>;

  return StockMetadata.fromJson(json);
}
