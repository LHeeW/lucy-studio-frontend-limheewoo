import 'package:edencrew_assignment_starter/widgets/skeleton/tile_skeleton.dart';
import 'package:flutter/material.dart';

class ListtileSkeleton extends StatelessWidget {
  const ListtileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return TileSkeleton();
      },
    );
  }
}
