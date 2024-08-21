import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/models/article/news_reponse.dart';
import 'package:lask/shared/components/list_row.dart';
import '../local/app_cubit/app_cubit.dart';
import 'list_card.dart';

class ExploreTap extends StatelessWidget {
  NewsResponse? articles;
  ExploreTap({required this.articles});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return (state is LoadingNews)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsetsDirectional.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 300,
                            child: ListCard(
                                article: articles!
                                    .articles[articles!.articles.length - 1]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListRow(
                                  article: articles!.articles[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 15,
                              );
                            },
                            itemCount: articles!.articles.length - 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
