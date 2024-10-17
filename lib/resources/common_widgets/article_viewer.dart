import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:junglee_news/config/utils.dart';
import 'package:junglee_news/features/dashboard/providers/saved_articles_provider.dart';
import 'package:junglee_news/features/dashboard/view_model/saved_articles_view_model.dart';
import 'package:junglee_news/repository/local/saved_articles_repo.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'image_overlay.dart';
import '../../model/article_model.dart';

class ArticleViewer extends StatelessWidget {
  final bool showBackButton;
  final ScrollController scrollController;
  final Article newsArticle;
  final double scrollControllerOffset;
  ArticleViewer(
      {super.key,
      required this.showBackButton,
      required this.newsArticle,
      required this.scrollController,
      required this.scrollControllerOffset});
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.parse(newsArticle.date.toString());

    final SavedArticlesRepo bookmarksRepo = SavedArticlesRepo();
    final SavedArticlesProvider bookmarksProvider =
        Provider.of<SavedArticlesProvider>(context, listen: false);
    final SavedArticlesViewModel savedArticlesViewModel =
        SavedArticlesViewModel(bookmarksRepo, bookmarksProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: showBackButton
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              )
            : null,
        title: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: CircleAvatar(
              //     radius: 25.0,
              //     backgroundColor: Colors.black.withOpacity(0.5),
              //     child: Center(
              //       child: IconButton(
              //         icon: const Icon(
              //           Icons.bookmark_outline,
              //           color: Colors.white,
              //           size: 30.0,
              //         ),
              //         onPressed: () =>
              //             savedArticlesViewModel.saveArticle(newsArticle),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: IconButton(
                        icon: Icon(
                          Icons.save_alt,
                          color: newsArticle.id == null
                              ? Colors.white
                              : Colors.blue,
                          size: 30.0,
                        ),
                        onPressed: () {
                          if (newsArticle.id != null) {
                            savedArticlesViewModel
                                .unSaveArticle(newsArticle.id!);
                            Utils.toast("Removed from your reading list.");
                            savedArticlesViewModel.fetchSavedArticleList();
                            Navigator.of(context).pop();
                          } else {
                            savedArticlesViewModel.saveArticle(newsArticle);
                            Utils.toast("Saved to your reading list.");
                          }
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.link,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        if (newsArticle.url != null) {
                          launchUrl(Uri.parse(newsArticle.url!));
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black
            .withOpacity((scrollControllerOffset / 350).clamp(0, 1).toDouble()),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        child: Container(
          // height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.6,
                    width: screenWidth,
                    child: Hero(
                      tag: "ArticleImage${newsArticle.url}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          child: ImageOverlay(
                            child: CachedNetworkImage(
                              height: double.infinity,
                              imageUrl: newsArticle.thumbnail ?? "",
                              fit: BoxFit.fitHeight,
                              placeholder: (context, url) => const Center(
                                child: SpinKitFadingCircle(
                                  color: Colors.amber,
                                  size: 35.0,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                // color: Color(0xffFAA0A0),
                                decoration: const BoxDecoration(
                                  // border: Border.all(color: Colors.black),
                                  color: Color(0xffFAA0A0),
                                ),
                                child: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2.0),
                          child: Text(
                            newsArticle.title.toString() ?? "",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: Text(
                            format.format(dateTime) ?? "",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  color: Colors.white,
                  // height: 0.65 * screenHeight,
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: newsArticle.authors!.isNotEmpty
                                  ? Row(
                                      children: [
                                        Text(
                                          newsArticle.authors!.isNotEmpty
                                              ? newsArticle.authors![0]
                                                  .toString()
                                                  .toUpperCase()
                                              : '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Icon(
                                          newsArticle.authors!.isNotEmpty
                                              ? Icons.verified
                                              : null,
                                          color: Colors.blue,
                                          size: 20.0,
                                        )
                                      ],
                                    )
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          newsArticle.content ?? newsArticle.title ?? "",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

//
// articleUrl: newsArticle.url,
// articleAuthor:
// newsArticle.authors![0].toString() ?? "",
// articleContent: newsArticle.content,
// articleExcerpt: newsArticle.excerpt,
// articleLanguage: newsArticle.language,
// articleThumbnail: newsArticle.thumbnail,
// articleTitle: newsArticle.title,
// articleDate: newsArticle.date
