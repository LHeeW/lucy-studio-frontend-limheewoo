import 'dart:convert';

import 'package:edencrew_assignment_starter/models/realtime.dart';
import 'package:edencrew_assignment_starter/models/stock.dart';
import 'package:edencrew_assignment_starter/models/stock_metadata.dart';
import 'package:edencrew_assignment_starter/services/naver_api_service_utils.dart';
import 'package:flutter/services.dart';

class NaverApiServiceMock {
  Future<List<Stock>> searchStocksFromMock() async {
    final jsonString = await rootBundle.loadString('assets/mock/search_stock.json');
    final json = jsonDecode(jsonString);

    return parseSearchResposne(json);
  }

  Future<List<Realtime>> realtimeFromMock() async {
    final jsonString = await rootBundle.loadString('assets/mock/realtime.json');
    final json = jsonDecode(jsonString);

    return parseRealtimeResponse(json);
  }

  Future<StockMetadata> stockMetadataFromMock() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/stock_metadata.json',
    );
    final json = jsonDecode(jsonString);

    return parseStockMetadataResponse(json);
  }
}
