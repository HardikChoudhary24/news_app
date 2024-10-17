import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:junglee_news/features/news_details/providers/news_article_provider.dart';
import 'package:junglee_news/model/article_model.dart';
import 'package:junglee_news/repository/local/saved_articles_repo.dart';
import 'package:junglee_news/services/response/response.dart';
import 'package:junglee_news/repository/remote/news_article_repo.dart';
import 'package:junglee_news/resources/common_widgets/article_viewer.dart';
import 'package:junglee_news/features/news_details/view_model/news_article_view_model.dart';
import 'package:provider/provider.dart';

import '../../../config/utils.dart';
import '../../../services/response/status.dart';
import '../../../repository/remote/remote_base_repo.dart';
import '../../../resources/common_widgets/error_alert.dart';

class NewsDetailsView extends StatefulWidget {
  final String? articleUrl;
  final String? id;

  const NewsDetailsView({super.key, required this.articleUrl, this.id});

  @override
  State<NewsDetailsView> createState() => _NewsDetailsViewState();
}

class _NewsDetailsViewState extends State<NewsDetailsView> {
  late NewsArticleViewModel newsArticleViewModel;
  late NewsArticleRepo newsArticleRepo;
  late SavedArticlesRepo savedArticlesRepo;
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsArticleRepo = NewsArticleRepo();
      savedArticlesRepo = SavedArticlesRepo();
      NewsArticleProvider newsArticleProvider =
          Provider.of<NewsArticleProvider>(context, listen: false);
      final newsArticleViewModel = NewsArticleViewModel(
          newsArticleRepo, newsArticleProvider, savedArticlesRepo);
      // final newsArticleRepo =
      //     Provider.of<NewsArticleRepo>(context, listen: false);

      newsArticleRepo.articleUrl = widget.articleUrl!;

      newsArticleViewModel.fetchNewsArticle(widget.id);
      // articleListViewModel.fetchArticleListByCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final format = DateFormat('MMMM dd, yyyy');
    return Consumer<NewsArticleProvider>(
      builder: (context, value, child) {
        Response<Article> response = value.getNewsArticle();
        print("the status is ${response.status}");
        if (response.status == Status.loading) {
          return const Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                size: 45.0,
                color: Colors.blueAccent,
              ),
            ),
          );
        } else if (response.status == Status.error) {
          Utils.toast(response.exception.toString());
          return Scaffold(
            body: Center(
              child: ErrorAlert(
                errorMssg: response.exception ?? "Something went wrong",
              ),
            ),
          );
        } else {
          Article newsArticle = response.data!;
          return ArticleViewer(
              showBackButton: true,
              newsArticle: newsArticle,
              scrollController: _scrollController,
              scrollControllerOffset: _scrollControllerOffset);
        }
      },
    );
  }
}
