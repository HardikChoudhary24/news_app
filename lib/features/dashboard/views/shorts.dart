import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:junglee_news/features/dashboard/providers/random_article_provider.dart';
import 'package:junglee_news/features/dashboard/view_model/random_article_view_model.dart';
import 'package:junglee_news/model/article_model.dart';
import 'package:junglee_news/services/response/response.dart';
import 'package:junglee_news/services/response/status.dart';
import 'package:junglee_news/resources/common_widgets/article_viewer.dart';
import 'package:provider/provider.dart';

import '../../../config/utils.dart';
import '../../../repository/remote/random_article_repo.dart';
import '../../../resources/common_widgets/error_alert.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class Shorts extends StatefulWidget {
  const Shorts({super.key});

  @override
  State<Shorts> createState() => _ShortsState();
}

class _ShortsState extends State<Shorts> {
  late RandomArticleViewModel randomArticleViewModel;
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
      final randomArticleProvider =
          Provider.of<RandomArticleProvider>(context, listen: false);
      RandomArticleRepo randomArticleRepo = RandomArticleRepo();
      randomArticleViewModel =
          RandomArticleViewModel(randomArticleRepo, randomArticleProvider);
      randomArticleViewModel.fetchRandomArticle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RandomArticleProvider>(
      builder: (context, randomArticleProvider, child) {
        Response<Article> response = randomArticleProvider.getNewsArticle();
        if (response.status == Status.loading) {
          return const Scaffold(
            backgroundColor: Colors.white,
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
          Article newsArticle = randomArticleProvider.getNewsArticle().data!;
          // return GestureDetector(
          //   onHorizontalDragEnd: (DragEndDetails) {
          //     print("Dragged");
          //     print(DragEndDetails.globalPosition);
          //   },
          //   child: ArticleViewer(
          //     newsArticle: newsArticle,
          //     scrollController: _scrollController,
          //     scrollControllerOffset: _scrollControllerOffset,
          //   ),
          // );
          return SwipeableTile(
            color: Colors.white,
            swipeThreshold: 0.1,
            direction: SwipeDirection.endToStart,
            onSwiped: (direction) {
              randomArticleViewModel.fetchRandomArticle();
            },
            backgroundBuilder: (context, direction, progress) {
              if (direction == SwipeDirection.endToStart) {
                return Container(
                  color: Colors.white,
                );
              } else if (direction == SwipeDirection.startToEnd) {
                return ArticleViewer(
                  showBackButton: false,
                  newsArticle: newsArticle,
                  scrollController: _scrollController,
                  scrollControllerOffset: _scrollControllerOffset,
                );
              }
              return ArticleViewer(
                showBackButton: false,
                newsArticle: newsArticle,
                scrollController: _scrollController,
                scrollControllerOffset: _scrollControllerOffset,
              );
            },
            key: UniqueKey(),
            child: ArticleViewer(
              showBackButton: false,
              newsArticle: newsArticle,
              scrollController: _scrollController,
              scrollControllerOffset: _scrollControllerOffset,
            ),
          );
          // return Consumer<RandomArticleViewModel>(
          //     builder: (context, randomArticleViewModel, child) {
          //   return SwipeableTile(
          //     color: Colors.white,
          //     swipeThreshold: 0.1,
          //     direction: SwipeDirection.endToStart,
          //     onSwiped: (direction) {
          //       randomArticleViewModel.fetchRandomArticle();
          //     },
          //     backgroundBuilder: (context, direction, progress) {
          //       if (direction == SwipeDirection.endToStart) {
          //         return Container(
          //           color: Colors.white,
          //         );
          //       } else if (direction == SwipeDirection.startToEnd) {
          //         return ArticleViewer(
          //           showBackButton: false,
          //           newsArticle: newsArticle,
          //           scrollController: _scrollController,
          //           scrollControllerOffset: _scrollControllerOffset,
          //         );
          //       }
          //       return ArticleViewer(
          //         showBackButton: false,
          //         newsArticle: newsArticle,
          //         scrollController: _scrollController,
          //         scrollControllerOffset: _scrollControllerOffset,
          //       );
          //     },
          //     key: UniqueKey(),
          //     child: ArticleViewer(
          //       showBackButton: false,
          //       newsArticle: newsArticle,
          //       scrollController: _scrollController,
          //       scrollControllerOffset: _scrollControllerOffset,
          //     ),
          //   );
          // });
        }
      },
    );
  }
}
