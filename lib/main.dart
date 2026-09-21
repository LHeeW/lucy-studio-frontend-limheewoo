import 'package:edencrew_assignment_starter/services/naver_api_service.dart';
import 'package:edencrew_assignment_starter/viewmodels/main_view_model.dart';
import 'package:edencrew_assignment_starter/viewmodels/searchlist_view_model.dart';
import 'package:edencrew_assignment_starter/viewmodels/watchlist_view_model.dart';
import 'package:edencrew_assignment_starter/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/theme.dart';

void main() {
  final apiService = NaverApiService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(
          create: (_) => SearchlistViewModel(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => WatchlistViewModel(apiService: apiService),
        ),
      ],
      child: const EdencrewAssignmentApp(),
    ),
  );
}

class EdencrewAssignmentApp extends StatelessWidget {
  const EdencrewAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '이든크루 평가 과제',
      theme: AppTheme.dark,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
