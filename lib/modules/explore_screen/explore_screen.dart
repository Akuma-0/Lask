import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/components/explore_tap.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return (state is LoadingNews)
            ? Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: 8, // Number of tabs
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: TabBar(
                        isScrollable: true,
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 20),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(text: 'All'),
                          Tab(text: 'Business'),
                          Tab(text: 'Entertainment'),
                          Tab(text: 'General'),
                          Tab(text: 'Health'),
                          Tab(text: 'Science'),
                          Tab(text: 'Sports'),
                          Tab(text: 'Technology'),
                        ],
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.primary,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ExploreTap(articles: cubit.topHeadlines),
                          ExploreTap(articles: cubit.business),
                          ExploreTap(articles: cubit.entertainment),
                          ExploreTap(articles: cubit.general),
                          ExploreTap(articles: cubit.health),
                          ExploreTap(articles: cubit.science),
                          ExploreTap(articles: cubit.sports),
                          ExploreTap(articles: cubit.technology),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
