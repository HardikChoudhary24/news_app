import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../features/dashboard/views/downloads.dart';
import '../features/dashboard/views/home.dart';
import '../features/dashboard/views/profile.dart';
import '../features/dashboard/views/shorts.dart';

class AppStateProvider extends ChangeNotifier {
  final dashBoardViews = [Home(), Shorts(), Bookmarks(), Profile()];
  int _activeDashboardView = 0;

  bool networkAvailable = true;

  bool isTextFieldFocused = true;

  setDashboardView(int index) {
    _activeDashboardView = index;
    notifyListeners();
  }

  Widget getActiveDashboardView() => dashBoardViews[_activeDashboardView];

  int getActiveDashboardIndex() => _activeDashboardView;

  void checkConnection() async {
    Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none)) {
          networkAvailable = false;
          notifyListeners();
        } else {
          networkAvailable = true;
          notifyListeners();
        }
      },
    );
  }
}
