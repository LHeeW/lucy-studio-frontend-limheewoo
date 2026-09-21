import 'package:edencrew_assignment_starter/models/realtime.dart';
import 'package:edencrew_assignment_starter/models/stock.dart';

class WatchlistItem {
  final Stock? stock;
  final Realtime? realtime;

  WatchlistItem({this.stock, this.realtime});
}
