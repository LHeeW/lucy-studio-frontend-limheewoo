class StockMetadata {
  final String symbolCode;
  final String stockName;
  final String stockExchangeNameKor;

  StockMetadata({
    required this.symbolCode,
    required this.stockName,
    required this.stockExchangeNameKor,
  });

  factory StockMetadata.fromJson(Map<String, dynamic> json) {
    return StockMetadata(
      symbolCode: json['symbolCode'] as String,
      stockName: json['stockName'] as String,
      stockExchangeNameKor: json['stockExchangeNameKor'] as String,
    );
  }
}
