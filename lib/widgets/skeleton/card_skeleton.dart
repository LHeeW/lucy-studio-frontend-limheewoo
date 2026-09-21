import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/widgets/skeleton/stick_skeleton.dart';
import 'package:flutter/material.dart';

class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final dimens = context.dimens;
    final colors = context.colors;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(dimens.space2),
        height: dimens.rowMinHeight,
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dimens.radiusMd),
          color: colors.surfaceSunken,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: dimens.space1,
          children: [
            StickSkeleton(width: dimens.space5, height: dimens.space2),
            StickSkeleton(width: dimens.space4, height: dimens.space2),
          ],
        ),
      ),
    );
  }
}
