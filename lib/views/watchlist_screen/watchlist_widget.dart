import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:edencrew_assignment_starter/viewmodels/watchlist_view_model.dart';
import 'package:edencrew_assignment_starter/views/stock_detail_screen/index.dart';
import 'package:edencrew_assignment_starter/widgets/custom_error.dart';
import 'package:edencrew_assignment_starter/widgets/empty_stock.dart';
import 'package:edencrew_assignment_starter/widgets/skeleton/listtile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WatchlistViewModel>();
    final colors = context.colors;
    final dimens = context.dimens;
    final numberFormat = NumberFormat.decimalPattern();

    if (viewModel.stocks.isEmpty) {
      return EmptyStock(
        icon: Icons.star_border_outlined,
        title: '관심 종목이 없습니다.',
        subTitle: '검색 탭에서 종목을 찾아 별 아이콘을 눌러 추가해 주세요.',
      );
    }

    return FutureBuilder(
      future: viewModel.watchlistFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListtileSkeleton();
        }

        if (snapshot.hasError) {
          return const SizedBox.expand(
            child: CustomErrorWidget(errorMessage: '실시간 시세를 불러오지 못했습니다.'),
          );
        }

        return ListView.builder(
          itemCount: viewModel.stocks.length,
          itemBuilder: (context, index) {
            final items = viewModel.watchlistItems[index];
            final realtime = items.realtime;
            if (realtime == null) {
              return const Text('데이터 없음.');
            }
            final change = realtime.currentPrice - realtime.previousClose;
            final changePercent = ((change / realtime.previousClose) * 100)
                .abs()
                .toStringAsFixed(2);
            final formattedPrice = numberFormat.format(realtime.currentPrice);
            final formattedChange = numberFormat.format(change.abs());
            final String sign = change > 0 ? "+" : (change < 0 ? "-" : "");
            final String changeText =
                "$sign$formattedChange ($sign$changePercent%)";

            return Column(
              children: [
                ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (conext) =>
                          StockDetailScreen(symbol: items.stock!.code),
                    ),
                  ),
                  title: Text(
                    items.stock!.name,
                    style: TextStyle(
                      fontSize: dimens.space4,
                      fontWeight: AppTypography.medium,
                      color: colors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    '${items.stock!.code} · ${items.stock!.typeName}',
                    style: TextStyle(
                      fontSize: dimens.space3,
                      color: colors.textSecondary,
                    ),
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formattedPrice,
                        style: TextStyle(
                          fontSize: dimens.space4,
                          fontWeight: AppTypography.medium,
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        changeText,
                        style: TextStyle(
                          fontSize: dimens.space3,
                          color: change > 0
                              ? colors.priceUpText
                              : (change < 0
                                    ? colors.priceDownText
                                    : colors.priceFlatText),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: colors.borderSubtle,
                  thickness: dimens.borderHairline,
                  height: dimens.borderHairline,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
