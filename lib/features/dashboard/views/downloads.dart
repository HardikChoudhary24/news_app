import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:junglee_news/features/dashboard/providers/saved_articles_provider.dart';
import 'package:junglee_news/features/dashboard/view_model/saved_articles_view_model.dart';
import 'package:junglee_news/features/dashboard/views/widgets/news_article_list.dart';
import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/repository/local/saved_articles_repo.dart';
import 'package:provider/provider.dart';

import '../../../model/article_model.dart';
import '../../../services/response/response.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  late final SavedArticlesProvider savedArticlesProvider;

  @override
  void initState() {
    super.initState();
    final SavedArticlesRepo _savedArticlesRepo = SavedArticlesRepo();
    savedArticlesProvider =
        Provider.of<SavedArticlesProvider>(context, listen: false);
    final SavedArticlesViewModel savedArticlesViewModel =
        SavedArticlesViewModel(_savedArticlesRepo, savedArticlesProvider);
    savedArticlesViewModel.fetchSavedArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Downloads",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Your saved articles.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Consumer<SavedArticlesProvider>(
                  builder: (context, bookmarksProvider, child) {
                    Response<ArticleList> response =
                        savedArticlesProvider.getSavedArticles;
                    return response.data != null
                        ? response.data!.data!.length == 0
                            ? Center(
                                child: Container(
                                  child: Text("No saved articles found!"),
                                ),
                              )
                            : NewsArticleList(
                                articles: response.data != null
                                    ? response.data!.data
                                    : [],
                                totalArticles: response.data != null
                                    ? response.data!.data!.length
                                    : 0)
                        : Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Container(
                              child: Text("No saved articles found!"),
                            ),
                          );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
