import 'dart:async';

import 'package:edencrew_assignment_starter/models/stock.dart';
import 'package:edencrew_assignment_starter/services/naver_api_service.dart';
import 'package:flutter/material.dart';

class SearchlistViewModel extends ChangeNotifier {
  final NaverApiService _apiService;

  SearchlistViewModel({required NaverApiService apiService})
    : _apiService = apiService;

  final TextEditingController textController = TextEditingController();

  List<Stock> _stocks = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _currentQuery = '';

  Timer? _debounce;

  List<Stock> get stocks => _stocks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get currentQuery => _currentQuery;

  void searchStocks(String query) {
    _debounce?.cancel();

    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      _stocks = [];
      _errorMessage = null;
      _isLoading = false;
      _currentQuery = '';
      notifyListeners();
      return;
    }

    _currentQuery = trimmedQuery;

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
        final stocks = await _apiService.searchStocksApi(trimmedQuery);

        _stocks = stocks;
      } catch (e) {
        _stocks = [];
        _errorMessage = '오류가 발생했습니다. 검색어를 다시 확인해주세요.';
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  void clearSearch() {
    textController.clear();
    _debounce?.cancel();

    _stocks = [];
    _errorMessage = null;
    _isLoading = false;
    _currentQuery = '';

    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
