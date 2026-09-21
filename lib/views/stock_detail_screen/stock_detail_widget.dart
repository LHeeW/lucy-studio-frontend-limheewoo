import 'package:edencrew_assignment_starter/models/realtime.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:edencrew_assignment_starter/viewmodels/stock_metadata_view_model.dart';
import 'package:edencrew_assignment_starter/views/stock_detail_screen/utils.dart';
import 'package:edencrew_assignment_starter/widgets/custom_error.dart';
import 'package:edencrew_assignment_starter/widgets/price_card.dart';
import 'package:edencrew_assignment_starter/widgets/skeleton/stock_detail_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StockDetailWidget extends StatelessWidget {
  const StockDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StockMetadataViewModel>();
    final numberFormat = NumberFormat.decimalPattern();
    final colors = context.colors;
    final dimens = context.dimens;

    return FutureBuilder(
      future: viewModel.stockDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const StockDetailSkeleton();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const CustomErrorWidget(errorMessage: '오류가 발생했습니다.');
        }

        final results = snapshot.data!;
        final realtimeList = results[2] as List<Realtime>;

        if (realtimeList.isEmpty) {
          return const CustomErrorWidget(errorMessage: '데이터가 없습니다.');
        }

        final realtime = realtimeList.first;
        final change = realtime.currentPrice - realtime.previousClose;
        final changePercent = ((change / realtime.previousClose) * 100)
            .abs()
            .toStringAsFixed(2);
        final formattedPrice = numberFormat.format(realtime.currentPrice);
        final formattedChange = numberFormat.format(change.abs());
        final formattedHigh = numberFormat.format(realtime.high).toString();
        final formattedLow = numberFormat.format(realtime.low).toString();
        final formattedTotal =
            realtime.currentPrice * realtime.countOfListedStock;
        final String sign = change > 0 ? "+" : (change < 0 ? "-" : "");
        final String arrow = change > 0 ? "▲" : (change < 0 ? '▼' : '');
        final String changeText =
            "$arrow $formattedChange ($sign$changePercent%)";

        return Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: dimens.space1,
            horizontal: dimens.space4,
          ),
          child: Column(
            children: [
              Row(
                spacing: dimens.space2,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formattedPrice,
                    style: TextStyle(
                      fontSize: dimens.space5 * 1.5,
                      fontWeight: AppTypography.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  Text(
                    changeText,
                    style: TextStyle(
                      fontSize: dimens.space4,
                      fontWeight: AppTypography.medium,
                      color: change > 0
                          ? colors.priceUpText
                          : (change < 0
                                ? colors.priceDownText
                                : colors.priceFlatText),
                    ),
                  ),
                ],
              ),
              SizedBox(height: dimens.space2),
              Column(
                spacing: dimens.space2,
                children: [
                  Row(
                    spacing: dimens.space2,
                    children: [
                      PriceCard(
                        title: '시가',
                        subTitle: formattedPrice.toString(),
                      ),
                      PriceCard(title: '고가', subTitle: formattedHigh),
                      PriceCard(title: '저가', subTitle: formattedLow),
                    ],
                  ),
                  Row(
                    spacing: dimens.space2,
                    children: [
                      PriceCard(
                        title: '거래량',
                        subTitle: formatMarketCap(realtime.countOfListedStock),
                      ),
                      PriceCard(
                        title: '시가총액',
                        subTitle: formatMarketCap(formattedTotal),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
