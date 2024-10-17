import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junglee_news/config/app_navigation//routes_name.dart';
import 'package:junglee_news/features/dashboard/views/news_dashboard.dart';
import 'package:junglee_news/features/news_details/views/news_details_view.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.newsDashboard:
        return MaterialPageRoute(builder: (_) => const NewsDashboard());
      case RoutesName.newsDetails:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        String articleUrl = arguments["url"];
        String? id = arguments["id"];
        return MaterialPageRoute(
            builder: (_) => NewsDetailsView(
                  articleUrl: articleUrl,
                  id: id,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Something went wrong!"),
              ),
            ),
          ),
        );
    }
  }
}
