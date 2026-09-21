import 'package:edencrew_assignment_starter/models/realtime.dart';
import 'package:edencrew_assignment_starter/models/stock.dart';
import 'package:edencrew_assignment_starter/models/watchlist_item.dart';
import 'package:edencrew_assignment_starter/services/naver_api_service.dart';
import 'package:flutter/material.dart';

enum WatchlistSortType { name, changePercent, currentPrice }

extension WatchlistSortTypeExtension on WatchlistSortType {
  String get title {
    switch (this) {
      case WatchlistSortType.name:
        return '가나다순';
      case WatchlistSortType.changePercent:
        return '등락률순';
      case WatchlistSortType.currentPrice:
        return '현재가순';
    }
  }
}

class WatchlistViewModel extends ChangeNotifier {
  final NaverApiService _apiService;

  WatchlistViewModel({required NaverApiService apiService})
    : _apiService = apiService {
    _watchlistFuture = loadRealtimePrices();
  }

  final List<Stock> _stocks = [];
  List<Realtime> _realtimePrices = [];
  WatchlistSortType _currentSortType = WatchlistSortType.name;

  late Future<void> _watchlistFuture;
  Future<void> get watchlistFuture => _watchlistFuture;

  List<Stock> get stocks => _stocks;
  WatchlistSortType get currentSortType => _currentSortType;

  List<WatchlistItem> get watchlistItems {
    final items = _stocks.map((stock) {
      Realtime? realtime;
      for (final item in _realtimePrices) {
        if (item.symbol == stock.code) {
          realtime = item;
          break;
        }
      }
      return WatchlistItem(stock: stock, realtime: realtime);
    }).toList();

    items.sort((a, b) {
      if (a.stock == null || b.stock == null) return 0;

      switch (_currentSortType) {
        case WatchlistSortType.name:
          return a.stock!.name.compareTo(b.stock!.name);
        case WatchlistSortType.changePercent:
          final percentA = a.realtime != null
              ? (a.realtime!.currentPrice - a.realtime!.previousClose) /
                    a.realtime!.previousClose
              : 0.0;
          final percentB = b.realtime != null
              ? (b.realtime!.currentPrice - b.realtime!.previousClose) /
                    b.realtime!.previousClose
              : 0.0;
          return percentB.compareTo(percentA);

        case WatchlistSortType.currentPrice:
          final priceA = a.realtime?.currentPrice ?? 0;
          final priceB = b.realtime?.currentPrice ?? 0;
          return priceB.compareTo(priceA);
      }
    });
    return items;
  }

  void changeSortType(WatchlistSortType sortType) {
    _currentSortType = sortType;
    notifyListeners();
  }

  bool isWatchlisted(String code) {
    return _stocks.any((stock) => stock.code == code);
  }

  Future<void> addStock(Stock stock) async {
    if (isWatchlisted(stock.code)) return;
    _stocks.add(stock);
    await reloadWatchlist();
  }

  Future<void> removeStock(String code) async {
    _stocks.removeWhere((stock) => stock.code == code);
    await reloadWatchlist();
  }

  void toggleStock(Stock stock) {
    if (isWatchlisted(stock.code)) {
      removeStock(stock.code);
    } else {
      addStock(stock);
    }
  }

  Future<void> loadRealtimePrices() async {
    if (_stocks.isEmpty) {
      _realtimePrices = [];
      return;
    }

    final results = <Realtime>[];
    for (final stock in _stocks) {
      final realtime = await _apiService.realtimeApi(stock.code);
      results.addAll(realtime);
    }
    _realtimePrices = results;
  }

  Future<void> reloadWatchlist() async {
    _watchlistFuture = loadRealtimePrices();
    notifyListeners();
  }
}
