import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:junglee_news/model/article_model.dart';
import 'package:junglee_news/config/app_navigation/routes_name.dart';
import 'package:junglee_news/features/news_details/view_model/news_article_view_model.dart';
import 'package:provider/provider.dart';

class NewsArticleCard extends StatelessWidget {
  final Article article;
  final format = DateFormat('MMMM dd, yyyy');
  NewsArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    DateTime date = DateTime.parse(article.date.toString());

    return GestureDetector(
      onTap: () {
        print("article id is : ${article.id}");
        Navigator.pushNamed(context, RoutesName.newsDetails,
            arguments: {"url": article.url ?? "", "id": article.id});
      },
      child: Container(
        color: Colors.white,
        height: screenHeight * 0.135,
        // padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Hero(
              tag: "ArticleImage${article.title}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                    height: screenHeight * 0.15,
                    width: screenWidth * 0.45,
                    child: CachedNetworkImage(
                      imageUrl: article.thumbnail.toString() ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: Colors.amber,
                            size: 35.0,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            color: Color(0xffFAA0A0)),
                      ),
                    )),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(
                  top: 5.0, left: 8.0, right: 8.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.5,
                    child: Text(
                      article.title.toString() ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          article.authors!.isNotEmpty
                              ? article.authors![0].toString()
                              : "",
                          style: GoogleFonts.poppins(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        child: Text(
                          format.format(date) ?? " ",
                          style: GoogleFonts.poppins(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
