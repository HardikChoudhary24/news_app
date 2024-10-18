import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:junglee_news/config/config.dart';
import 'package:junglee_news/features/dashboard/providers/article_list_provider.dart';
import 'package:junglee_news/features/dashboard/providers/category_list_provider.dart';
import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/model/category_list_model.dart';
import 'package:junglee_news/features/dashboard/view_model/category_list_view_model.dart';
import 'package:junglee_news/repository/local/local_article_list_repo.dart';
import 'package:junglee_news/repository/remote/category_list_repo.dart';
import 'package:junglee_news/repository/remote/news_articles_list_repo.dart';
import 'package:junglee_news/resources/app_state_provider.dart';
import 'package:junglee_news/resources/network_checker_wrapper.dart';
import 'package:provider/provider.dart';

import '../../../config/utils.dart';
import '../../../services/response/response.dart';
import '../../../services/response/status.dart';
import '../../../repository/remote/remote_base_repo.dart';
import 'widgets/custom_text_field.dart';
import '../../../resources/common_widgets/error_alert.dart';
import 'widgets/news_article_list.dart';
import '../view_model/articles_list_view_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ArticlesListViewModel articlesListViewModel;
  late CategoryListViewModel categoryListViewModel;

  @override
  void initState() {
    print("this is initiated");
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final articleListRepo = NewsArticlesListRepo();
      final categoryListRepo = CategoryListRepo();
      final localArticleListRepo = LocalArticleListRepo();

      final articleListProvider =
          Provider.of<ArticlesListProvider>(context, listen: false);
      final categoryListProvider =
          Provider.of<CategoryListProvider>(context, listen: false);

      articlesListViewModel = ArticlesListViewModel(
          articleListRepo, articleListProvider, localArticleListRepo);
      categoryListViewModel =
          CategoryListViewModel(categoryListRepo, categoryListProvider);

      categoryListViewModel.fetchCategoryList();
      articlesListViewModel.fetchArticleListByCategory();
    });

    AppStateProvider appStateProvider =
        Provider.of<AppStateProvider>(context, listen: false);

    appStateProvider.checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final nameController = TextEditingController();
    return SafeArea(child:
        Consumer<AppStateProvider>(builder: (builder, appStateProvider, child) {
      return Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "News from around the world",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  // NetworkCheckerWrapper(
                  //   childWidget: Consumer<ArticlesListViewModel>(
                  //       builder: (context, articleListViewModel, child) {
                  //     return CustomTextField(
                  //       allowDebouncing: true,
                  //       onSubmit: (query) {
                  //         if (query.isNotEmpty) {
                  //           articleListViewModel.fetchArticleListByQuery(
                  //               query: query);
                  //         } else {
                  //           return Utils.toast(
                  //               "Please enter what you're looking for!");
                  //         }
                  //       },
                  //       controller: nameController,
                  //       name: "Search",
                  //       prefixIcon: Icons.search,
                  //       inputType: TextInputType.name,
                  //     );
                  //   }),
                  // ),
                  NetworkCheckerWrapper(
                      childWidget: CustomTextField(
                    allowDebouncing: true,
                    onSubmit: (query) {
                      if (query.isNotEmpty) {
                        articlesListViewModel.fetchArticleListByQuery(
                            query: query);
                      } else {
                        return Utils.toast(
                            "Please enter what you're looking for!");
                      }
                    },
                    controller: nameController,
                    name: "Search",
                    prefixIcon: Icons.search,
                    inputType: TextInputType.name,
                  )),
                  NetworkCheckerWrapper(
                    childWidget: Container(
                      height: 30,
                      child: Consumer<CategoryListProvider>(
                          builder: (context, value, child) {
                        Response<CategoryList> response =
                            value.getCategoryList();
                        if (response.status == Status.loading) {
                          return const SpinKitWave(
                            size: 15.0,
                            color: Colors.blueAccent,
                          );
                        } else if (response.status == Status.error) {
                          Utils.toast(response.exception.toString());
                          // return const ErrorAlert();
                          return SizedBox(
                            width: 0,
                            height: 0,
                          );
                        } else {
                          // return Consumer<ArticlesListViewModel>(
                          //     builder: (context, articleListViewModel, child) {
                          //   return ListView.separated(
                          //     separatorBuilder: (context, index) {
                          //       return SizedBox(
                          //         width: 15.0,
                          //       );
                          //     },
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) {
                          //       bool isSelectedCategory =
                          //           value.getSelectedCategory().name ==
                          //               response.data!.categories![index].name;
                          //       return GestureDetector(
                          //         onTap: () {
                          //           value.setSelectedCategory(
                          //               response.data!.categories![index]);
                          //           articleListViewModel
                          //               .fetchArticleListByCategory(
                          //                   category: value
                          //                       .getSelectedCategory()
                          //                       .name);
                          //         },
                          //         child: Container(
                          //             padding: EdgeInsets.symmetric(
                          //                 horizontal: 15.0),
                          //             decoration: BoxDecoration(
                          //               color: isSelectedCategory
                          //                   ? Colors.blue.shade700
                          //                   : Color(0xFFEDECEC),
                          //               borderRadius:
                          //                   BorderRadius.circular(20.0),
                          //             ),
                          //             child: Center(
                          //               child: Text(
                          //                 response.data!.categories![index]
                          //                         .name ??
                          //                     "",
                          //                 style: GoogleFonts.poppins(
                          //                   fontSize: 10.0,
                          //                   color: isSelectedCategory
                          //                       ? Colors.white
                          //                       : Color(0xFF8C8989),
                          //                 ),
                          //               ),
                          //             )),
                          //       );
                          //     },
                          //     itemCount: response.data!.categories!.length ?? 0,
                          //   );
                          // });
                          return ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 15.0,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              bool isSelectedCategory =
                                  value.getSelectedCategory().name ==
                                      response.data!.categories![index].name;
                              return GestureDetector(
                                onTap: () {
                                  value.setSelectedCategory(
                                      response.data!.categories![index]);
                                  articlesListViewModel
                                      .fetchArticleListByCategory(
                                          category:
                                              value.getSelectedCategory().name);
                                },
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    decoration: BoxDecoration(
                                      color: isSelectedCategory
                                          ? Colors.blue.shade700
                                          : Color(0xFFEDECEC),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        response.data!.categories![index]
                                                .name ??
                                            "",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10.0,
                                          color: isSelectedCategory
                                              ? Colors.white
                                              : Color(0xFF8C8989),
                                        ),
                                      ),
                                    )),
                              );
                            },
                            itemCount: response.data!.categories!.length ?? 0,
                          );
                        }
                      }),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                child: Consumer<ArticlesListProvider>(
                  builder: (context, value, child) {
                    Response<ArticleList> response = value.getArticleList;
                    if (response.status == Status.loading) {
                      return const SpinKitFadingCircle(
                        size: 45.0,
                        color: Colors.blueAccent,
                      );
                    } else if (response.status == Status.error) {
                      // Utils.toast(response.exception.toString());
                      return ErrorAlert(
                        errorMssg: response.exception?.toString() ??
                            "Something went wrong!",
                      );
                    } else {
                      return NewsArticleList(
                          articles: response.data!.data ?? [],
                          totalArticles: response.data!.size ?? 0);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      );
    }));
  }
}