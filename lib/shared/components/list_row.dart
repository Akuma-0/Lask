import 'package:floating_tabbar/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';

import '../../models/article/article.dart';
import '../../modules/web_view/web_view_screen.dart';
import '../local/hive/hive_helper.dart';

class ListRow extends StatelessWidget {
  Article article;

  ListRow({required this.article}) {
    var savedArticles = saved!.get('articlesMap') ?? {};
    if (savedArticles[article.hashCode] != null)
      article.isSaved = true;
    else
      article.isSaved = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(url: article.url),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: (article.image == 'null' || article.image == '')
                        ? Image.asset(
                            'assets/images/no-image.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            article.image,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        article.title,
                        textDirection: TextDirection.rtl,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              article.date,
                              textDirection: TextDirection.ltr,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              article.author,
                              textDirection: TextDirection.rtl,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (article.isSaved) {
                      article.isSaved = false;
                      AppCubit.get(context).removeArticle(article);
                    } else {
                      article.isSaved = true;
                      AppCubit.get(context).saveArticle(article);
                    }
                  },
                  icon: (article.isSaved)
                      ? Icon(
                          Icons.bookmark,
                          color: Colors.grey,
                          size: 25,
                        )
                      : Icon(
                          Icons.bookmark_border,
                          color: Colors.grey,
                          size: 25,
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
