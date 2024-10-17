import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/model/article_model.dart';

import 'news_article_card.dart';

class NewsArticleList extends StatefulWidget {
  final List<Article>? articles;
  final int totalArticles;
  const NewsArticleList(
      {super.key, required this.articles, required this.totalArticles});

  @override
  State<NewsArticleList> createState() => _NewsArticleListState();
}

class _NewsArticleListState extends State<NewsArticleList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(bottom: 5.0),
      scrollDirection: Axis.vertical,
      separatorBuilder: (BuildContext context, _) {
        return const SizedBox(
          height: 10.0,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return NewsArticleCard(article: widget.articles![index]);
      },
      itemCount: widget.articles != null ? widget.articles!.length : 0,
    );
  }
}
