import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

//삼전 목데이터 추출
Future<void> main() async {
  final dio = Dio();

  final response = await dio.get(
    'https://stock.naver.com/api/securityFe/api/fchart/domestic/stock/005930',
  );

  final file = File('assets/mock/stock_metadata.json');

  await file.writeAsString(
    const JsonEncoder.withIndent(' ').convert(response.data),
  );
}
