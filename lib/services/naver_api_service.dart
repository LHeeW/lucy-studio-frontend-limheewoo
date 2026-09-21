import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edencrew_assignment_starter/models/realtime.dart';
import 'package:edencrew_assignment_starter/models/stock.dart';
import 'package:edencrew_assignment_starter/models/stock_metadata.dart';
import 'package:edencrew_assignment_starter/services/naver_api_service_utils.dart';

class NaverApiService {
  final _dio = Dio();

  Future<List<Stock>> searchStocksApi(String query) async {
    final response = await _dio.get(
      'https://ac.stock.naver.com/ac',
      queryParameters: {
        'q': query,
        'target': 'stock,ipo,index,marketindicator',
      },
    );

    return parseSearchResposne(response.data);
  }

  Future<List<Realtime>> realtimeApi(String query) async {
    final response = await _dio.get(
      'https://polling.finance.naver.com/api/realtime',
      queryParameters: {'query': 'SERVICE_ITEM:$query'},
    );

    final data = jsonDecode(response.data);

    return parseRealtimeResponse(data);
  }

  Future<StockMetadata> stockMetadata(String symbol) async {
    final response = await _dio.get(
      'https://stock.naver.com/api/securityFe/api/fchart/domestic/stock/$symbol',
    );

    return parseStockMetadataResponse(response.data);
  }
}
