import 'package:junglee_news/config/config.dart';

class ApiUrl {
  static const String baseUrl = "https://newsapi.org/v2";

  static String getTopHeadlinesUrl(
      {String country = 'us', String topic = "General", int page = 2}) {
    return "https://news-api14.p.rapidapi.com/v2/trendings?topic=$topic&language=en&country=$country&page=$page";
  }

  static String getHeadlineContentUrl({required String articleUrl}) {
    print(
        "https://news-api14.p.rapidapi.com/v2/article?url=$articleUrl&type=plaintext");
    return "https://news-api14.p.rapidapi.com/v2/article?url=$articleUrl&type=plaintext";
  }

  static String getSupportedTopicsUrl() {
    return "https://news-api14.p.rapidapi.com/v2/info/topics";
  }

  static String getSupportedCountriesUrl() {
    return "https://news-api14.p.rapidapi.com/v2/info/countries";
  }

  static String getRandomArticleGeneratorUrl() {
    return "https://news-api14.p.rapidapi.com/v2/article/random?language=en&type=plaintext";
  }

  static String getSearchArticlesUrl({required String query}) {
    return "https://news-api14.p.rapidapi.com/v2/search/articles?query=$query&language=en";
  }
}
