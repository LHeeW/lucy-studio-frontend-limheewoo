import 'package:edencrew_assignment_starter/models/stock.dart';
import 'package:edencrew_assignment_starter/models/stock_metadata.dart';
import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:edencrew_assignment_starter/viewmodels/stock_metadata_view_model.dart';
import 'package:edencrew_assignment_starter/widgets/skeleton/stick_skeleton.dart';
import 'package:edencrew_assignment_starter/widgets/star_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockDetailHeaderWidget extends StatelessWidget {
  const StockDetailHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StockMetadataViewModel>();
    final colors = context.colors;
    final dimens = context.dimens;

    return Column(
      children: [
        ListTile(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: colors.textSecondary,
              size: dimens.iconMd,
            ),
          ),

          title: FutureBuilder(
            future: viewModel.stockDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return StickSkeleton(
                  width: dimens.space5 * 2,
                  height: dimens.space2,
                );
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Text('-');
              }
              final results = snapshot.data!;
              final stockMetadata = results[0] as StockMetadata?;
              return Text(
                stockMetadata?.stockName ?? '',
                style: TextStyle(
                  fontSize: dimens.space4,
                  fontWeight: AppTypography.medium,
                  color: colors.textPrimary,
                ),
              );
            },
          ),

          subtitle: FutureBuilder(
            future: viewModel.stockDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return StickSkeleton(
                  width: dimens.space5 * 2,
                  height: dimens.space2,
                );
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Text('-');
              }
              final results = snapshot.data!;
              final stockMetadata = results[0] as StockMetadata?;
              return Text(
                "${stockMetadata?.symbolCode ?? ''} · ${stockMetadata?.stockExchangeNameKor ?? ''}",
                style: TextStyle(
                  fontSize: dimens.space3,
                  color: colors.textSecondary,
                ),
              );
            },
          ),

          trailing: FutureBuilder(
            future: viewModel.stockDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final results = snapshot.data!;
                final stock = results[1] as List<Stock>?;
                if (stock != null && stock.isNotEmpty) {
                  return StarButton(stock: stock.first);
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        Divider(
          color: colors.borderSubtle,
          thickness: dimens.borderHairline,
          height: dimens.borderHairline,
        ),
      ],
    );
  }
}
