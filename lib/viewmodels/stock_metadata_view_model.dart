import 'package:edencrew_assignment_starter/services/naver_api_service.dart';
import 'package:flutter/material.dart';

class StockMetadataViewModel extends ChangeNotifier {
  final NaverApiService _apiService;
  final String symbol;
  late final Future<List<dynamic>> stockDetailFuture;

  StockMetadataViewModel({
    required NaverApiService apiService,
    required this.symbol,
  }) : _apiService = apiService {
    stockDetailFuture = _loadStockDetail();
  }

  Future<List<dynamic>> _loadStockDetail() async {
    return await Future.wait([
      _apiService.stockMetadata(symbol),
      _apiService.searchStocksApi(symbol),
      _apiService.realtimeApi(symbol),
    ]);
  }
}
