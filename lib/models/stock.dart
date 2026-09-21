class Stock {
  final String id;
  final String code;
  final String name;
  final String typeCode;
  final String typeName;
  final String url;
  final String nationCode;
  final String category;

  Stock({
    required this.id,
    required this.code,
    required this.name,
    required this.typeCode,
    required this.typeName,
    required this.url,
    required this.nationCode,
    required this.category,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: 'domestic:${json['code'] as String}',
      code: json['code'] as String,
      name: json['name'] as String,
      typeCode: json['typeCode'] as String,
      typeName: json['typeName'] as String,
      url: json['url'] as String,
      nationCode: json['nationCode'] as String,
      category: json['category'] as String,
    );
  }
}
