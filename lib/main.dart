import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:junglee_news/config/app_navigation/routes.dart';
import 'package:junglee_news/config/app_navigation/routes_name.dart';
import 'package:junglee_news/features/dashboard/providers/article_list_provider.dart';
import 'package:junglee_news/features/dashboard/providers/saved_articles_provider.dart';
import 'package:junglee_news/features/dashboard/providers/category_list_provider.dart';
import 'package:junglee_news/features/dashboard/providers/random_article_provider.dart';
import 'package:junglee_news/features/dashboard/view_model/saved_articles_view_model.dart';
import 'package:junglee_news/features/dashboard/view_model/random_article_view_model.dart';
import 'package:junglee_news/features/news_details/providers/news_article_provider.dart';
import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/model/category_list_model.dart';
import 'package:junglee_news/repository/local/local_base_repo.dart';
import 'package:junglee_news/repository/local/saved_articles_repo.dart';
import 'package:junglee_news/repository/remote/remote_base_repo.dart';
import 'package:junglee_news/repository/remote/category_list_repo.dart';
import 'package:junglee_news/repository/remote/news_article_repo.dart';
import 'package:junglee_news/repository/remote/news_articles_list_repo.dart';
import 'package:junglee_news/features/dashboard/view_model/category_list_view_model.dart';
import 'package:junglee_news/features/news_details/view_model/news_article_view_model.dart';
import 'package:junglee_news/features/dashboard/view_model/articles_list_view_model.dart';
import 'package:junglee_news/repository/remote/random_article_repo.dart';
import 'package:junglee_news/resources/app_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/article_model.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _saveLastUsedTimestamp();
    }
  }

  Future<void> _saveLastUsedTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    await prefs.setString("last_used_timestamp", now.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>(
            create: (_) => AppStateProvider()),
        ChangeNotifierProvider<ArticlesListProvider>(
            create: (context) => ArticlesListProvider()),
        ChangeNotifierProvider<CategoryListProvider>(
            create: (context) => CategoryListProvider()),
        ChangeNotifierProvider<NewsArticleProvider>(
            create: (context) => NewsArticleProvider()),
        ChangeNotifierProvider<RandomArticleProvider>(
            create: (context) => RandomArticleProvider()),
        ChangeNotifierProvider<SavedArticlesProvider>(
            create: (context) => SavedArticlesProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.newsDashboard,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}