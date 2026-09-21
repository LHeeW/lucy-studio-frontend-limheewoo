import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(dimens.space2),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dimens.radiusMd),
          color: colors.surfaceSunken,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: dimens.space3,
                color: colors.textSecondary,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: dimens.space4,
                fontWeight: AppTypography.medium,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
