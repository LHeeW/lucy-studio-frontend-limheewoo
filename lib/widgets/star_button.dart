import 'package:edencrew_assignment_starter/models/stock.dart';
import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:edencrew_assignment_starter/viewmodels/watchlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarButton extends StatelessWidget {
  const StarButton({super.key, required this.stock});

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WatchlistViewModel>();
    final colors = context.colors;
    final dimens = context.dimens;

    return IconButton(
      icon: Icon(
        viewModel.isWatchlisted(stock.code)
            ? Icons.star
            : Icons.star_border_outlined,
        color: viewModel.isWatchlisted(stock.code)
            ? colors.favoriteActive
            : colors.favoriteInactive,
        size: dimens.iconMd,
      ),
      onPressed: () {
        viewModel.toggleStock(stock);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: colors.surfaceOverlay,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.fromLTRB(
              dimens.space4,
              0,
              dimens.space4,
              dimens.space3,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(dimens.space3),
            ),
            content: Row(
              children: [
                Icon(
                  viewModel.isWatchlisted(stock.code)
                      ? Icons.star
                      : Icons.star_border_outlined,
                  color: viewModel.isWatchlisted(stock.code)
                      ? colors.favoriteActive
                      : colors.favoriteInactive,
                  size: dimens.iconMd,
                ),
                SizedBox(width: dimens.space2),
                Text(
                  viewModel.isWatchlisted(stock.code)
                      ? "관심이 등록되었습니다."
                      : "관심이 해제되었습니다.",
                  style: TextStyle(
                    fontSize: dimens.space3,
                    fontWeight: AppTypography.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 300),
          ),
        );
      },
    );
  }
}
