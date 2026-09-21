import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:flutter/material.dart';

class EmptyStock extends StatelessWidget {
  const EmptyStock({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  final IconData? icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: dimens.iconMd * 2),
          Text(
            title,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: dimens.space5,
              fontWeight: AppTypography.bold,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: colors.textTertiary,
              fontSize: dimens.space3,
            ),
          ),
        ],
      ),
    );
  }
}
