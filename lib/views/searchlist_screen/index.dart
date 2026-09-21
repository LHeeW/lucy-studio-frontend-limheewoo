import 'package:edencrew_assignment_starter/views/searchlist_screen/search_input_widget.dart';
import 'package:edencrew_assignment_starter/views/searchlist_screen/searchlist_widget.dart';
import 'package:flutter/material.dart';

class SearchlistScreen extends StatelessWidget {
  const SearchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchInputWidget(),
        Expanded(child: SearchListWidget()),
      ],
    );
  }
}
