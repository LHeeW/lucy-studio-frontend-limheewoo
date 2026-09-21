class Realtime {
  final String symbol;
  final int currentPrice;
  final int previousClose;
  final int open;
  final int high;
  final int low;
  final int volume;
  final int countOfListedStock;

  Realtime({
    required this.symbol,
    required this.currentPrice,
    required this.previousClose,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.countOfListedStock,
  });

  factory Realtime.fromJson(Map<String, dynamic> json) {
    return Realtime(
      symbol: json['cd'] as String,
      currentPrice: json['nv'] as int,
      previousClose: json['pcv'] as int,
      open: json['ov'] as int,
      high: json['hv'] as int,
      low: json['lv'] as int,
      volume: json['aq'] as int,
      countOfListedStock: json['countOfListedStock'] as int,
    );
  }
}
