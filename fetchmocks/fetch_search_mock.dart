import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

Future<void> main() async {
  final dio = Dio();

  final response = await dio.get(
    'https://ac.stock.naver.com/ac',
    queryParameters: {'q': '삼성', 'target': 'stock,ipo,index,marketindicator'},
  );

  final file = File('assets/mock/search_stock.json');

  await file.writeAsString(
    const JsonEncoder.withIndent(' ').convert(response.data),
  );
}
