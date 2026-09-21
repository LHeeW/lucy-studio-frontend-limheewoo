import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/widgets/skeleton/stick_skeleton.dart';
import 'package:flutter/material.dart';

class TileSkeleton extends StatelessWidget {
  const TileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return Column(
      children: [
        SizedBox(
          height: dimens.rowMinHeight,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 0,
              horizontal: dimens.space4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: dimens.space1,
                  children: [
                    StickSkeleton(
                      width: dimens.space5 * 4,
                      height: dimens.space2,
                    ),
                    StickSkeleton(
                      width: dimens.space4 * 4,
                      height: dimens.space2,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: dimens.space1,
                  children: [
                    StickSkeleton(
                      width: dimens.space5 * 4,
                      height: dimens.space2,
                    ),
                    StickSkeleton(
                      width: dimens.space4 * 4,
                      height: dimens.space2,
                    ),
                  ],
                ),
              ],
            ),
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
