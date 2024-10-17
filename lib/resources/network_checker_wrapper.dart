import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:junglee_news/resources/app_state_provider.dart';
import 'package:provider/provider.dart';

class NetworkCheckerWrapper extends StatelessWidget {
  Widget childWidget;
  NetworkCheckerWrapper({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
        builder: (context, appStateProvider, child) {
      if (appStateProvider.networkAvailable) {
        return childWidget;
      } else {
        return Container();
      }
    });
  }
}
