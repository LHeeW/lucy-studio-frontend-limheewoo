import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/widgets/skeleton/card_skeleton.dart';
import 'package:edencrew_assignment_starter/widgets/skeleton/stick_skeleton.dart';

import 'package:flutter/material.dart';

class StockDetailSkeleton extends StatelessWidget {
  const StockDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = context.dimens;

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
              StickSkeleton(width: dimens.space5 * 4, height: dimens.space4),
            ],
          ),
          SizedBox(height: dimens.space2),
          Column(
            spacing: dimens.space2,
            children: [
              Row(
                spacing: dimens.space2,
                children: [CardSkeleton(), CardSkeleton(), CardSkeleton()],
              ),
              Row(
                spacing: dimens.space2,
                children: [CardSkeleton(), CardSkeleton()],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
