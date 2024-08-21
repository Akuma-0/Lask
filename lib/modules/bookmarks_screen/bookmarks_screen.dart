import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';

import '../../shared/components/list_row.dart';

class BookmarksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var articles = cubit.savedArticles.values.toList();
        return (articles.isEmpty)
            ? Center(
                child: Text(
                  'No saved articles',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListRow(article: articles[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: articles.length,
                ),
              );
      },
    );
  }
}
