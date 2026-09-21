import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StickSkeleton extends StatelessWidget {
  const StickSkeleton({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: width,
        height: height,
        color: colors.feedbackSkeleton,
      ),
    );
  }
}
