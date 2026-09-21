import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:edencrew_assignment_starter/viewmodels/searchlist_view_model.dart';
import 'package:edencrew_assignment_starter/views/searchlist_screen/highlight_match.widget.dart';
import 'package:edencrew_assignment_starter/views/stock_detail_screen/index.dart';
import 'package:edencrew_assignment_starter/widgets/custom_error.dart';
import 'package:edencrew_assignment_starter/widgets/empty_stock.dart';
import 'package:edencrew_assignment_starter/widgets/custom_loading.dart';
import 'package:edencrew_assignment_starter/widgets/star_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchlistViewModel>();
    final colors = context.colors;
    final dimens = context.dimens;

    if (viewModel.isLoading) {
      return SizedBox.expand(child: CustomLoadingWidget());
    }

    if (viewModel.errorMessage != null) {
      return SizedBox.expand(
        child: CustomErrorWidget(errorMessage: viewModel.errorMessage!),
      );
    }

    if (viewModel.stocks.isEmpty) {
      return EmptyStock(
        icon: viewModel.currentQuery.isNotEmpty
            ? Icons.search_off
            : Icons.search,
        title: viewModel.currentQuery.isNotEmpty
            ? '검색 결과가 없습니다.'
            : '종목을 검색해 보세요',
        subTitle: viewModel.currentQuery.isNotEmpty
            ? '${viewModel.currentQuery}와 일치하는 검색 결과를 찾기 못했습니다.'
            : '종목별 또는 종목코드 6자리로 검색하실 수 있습니다.',
      );
    }

    return ListView.builder(
      itemCount: viewModel.stocks.length,
      itemBuilder: (context, index) {
        final stock = viewModel.stocks[index];
        final defaultStyle = TextStyle(
          fontSize: dimens.space4,
          fontWeight: AppTypography.medium,
          color: colors.textPrimary,
        );
        final highlightStyle = TextStyle(
          fontSize: dimens.space4,
          fontWeight: AppTypography.medium,
          color: colors.searchHighlight,
        );
        return Column(
          children: [
            ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (conext) => StockDetailScreen(symbol: stock.code),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  children: highlightMatch(
                    stock.name,
                    viewModel.currentQuery, // 사용자가 입력한 검색어 전달
                    defaultStyle,
                    highlightStyle,
                  ),
                ),
              ),
              subtitle: Text(
                '${stock.code} · ${stock.typeName}',
                style: TextStyle(
                  fontSize: dimens.space3,
                  color: colors.textSecondary,
                ),
              ),
              trailing: StarButton(stock: stock),
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
  }
}
