import 'package:edencrew_assignment_starter/services/naver_api_service.dart';
import 'package:edencrew_assignment_starter/viewmodels/stock_metadata_view_model.dart';
import 'package:edencrew_assignment_starter/views/stock_detail_screen/stock_detail_header_widget.dart';
import 'package:edencrew_assignment_starter/views/stock_detail_screen/stock_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockDetailScreen extends StatelessWidget {
  const StockDetailScreen({super.key, required this.symbol});
  final String symbol;

  @override
  Widget build(BuildContext context) {
    final apiService = NaverApiService();

    return ChangeNotifierProvider(
      create: (context) =>
          StockMetadataViewModel(apiService: apiService, symbol: symbol),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              StockDetailHeaderWidget(),
              Expanded(child: StockDetailWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
