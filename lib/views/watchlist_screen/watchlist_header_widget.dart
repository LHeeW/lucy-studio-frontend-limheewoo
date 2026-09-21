import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:edencrew_assignment_starter/viewmodels/watchlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistHeaderWidget extends StatelessWidget {
  const WatchlistHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WatchlistViewModel>();
    final colors = context.colors;
    final dimens = context.dimens;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.only(left: dimens.space4),
          child: Text(
            '관심',
            style: TextStyle(
              fontSize: dimens.space5,
              fontWeight: AppTypography.bold,
              color: colors.textPrimary,
            ),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.all(14),
                            child: Text(
                              '정렬',
                              style: TextStyle(
                                fontSize: dimens.space5,
                                fontWeight: AppTypography.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: WatchlistSortType.values.length,
                            itemBuilder: (context, index) {
                              final sortType = WatchlistSortType.values[index];
                              final isSelected =
                                  viewModel.currentSortType == sortType;

                              return ListTile(
                                title: Text(
                                  sortType.title,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? AppTypography.bold
                                        : AppTypography.medium,
                                    color: isSelected
                                        ? colors.textPrimary
                                        : colors.textSecondary,
                                  ),
                                ),
                                trailing: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: colors.textPrimary,
                                      )
                                    : null,
                                onTap: () {
                                  viewModel.changeSortType(sortType);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Text(
                    viewModel.currentSortType.title,
                    style: TextStyle(
                      fontSize: dimens.space3,
                      fontWeight: AppTypography.bold,
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(width: dimens.space1),
                  Icon(
                    Icons.arrow_downward,
                    color: colors.textSecondary,
                    size: dimens.iconMd,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<WatchlistViewModel>().reloadWatchlist();
              },
              icon: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.autorenew,
                  color: colors.textSecondary,
                  size: dimens.iconMd,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
