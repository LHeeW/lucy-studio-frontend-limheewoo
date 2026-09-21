import 'package:edencrew_assignment_starter/views/watchlist_screen/watchlist_header_widget.dart';
import 'package:edencrew_assignment_starter/views/watchlist_screen/watchlist_widget.dart';
import 'package:flutter/material.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WatchlistHeaderWidget(),
        Expanded(child: WatchlistWidget()),
      ],
    );
  }
}
