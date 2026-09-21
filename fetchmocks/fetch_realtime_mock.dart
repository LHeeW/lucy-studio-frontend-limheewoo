import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

Future<void> main() async {
  final dio = Dio();

  final response = await dio.get(
    'https://polling.finance.naver.com/api/realtime',
    queryParameters: {'query': 'SERVICE_ITEM:005930,448330'},
  );

  final data = jsonDecode(response.data);

  final file = File('assets/mock/realtime.json');

  await file.writeAsString(const JsonEncoder.withIndent(' ').convert(data));
}
