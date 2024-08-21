import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

import '../modules/search/search_screen.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: AppCubit.get(context).titles[AppCubit.get(context).navIndex],
            actions: (AppCubit.get(context).navIndex == 1)
                ? <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.search),
                    )
                  ]
                : (AppCubit.get(context).navIndex == 0)
                    ? <Widget>[
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).changeIndex(3);
                          },
                          child: (AppCubit.get(context).city == null ||
                                  AppCubit.get(context).weather == null)
                              ? Text('Choose a city')
                              : Container(
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://openweathermap.org/img/wn/${AppCubit.get(context).weather.icon}.png',
                                      ),
                                      Text(
                                        AppCubit.get(context).weather.main,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${AppCubit.get(context).weather.temp.round()}°',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                        )
                      ]
                    : null,
          ),
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: AppCubit.get(context).navIndex,
            fontSize: 18,
            activeIconColor: Theme.of(context).colorScheme.surface,
            activeButtonFlexFactor: 120,
            backgroundOpacity: 0,
            inactiveIconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            navigationBarButtons: [
              NavigationBarButton(
                text: 'Home',
                icon: Icons.home_outlined,
                textColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              NavigationBarButton(
                text: 'Explore',
                icon: Icons.public,
                textColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              NavigationBarButton(
                text: 'Bookmarks',
                icon: Icons.book_outlined,
                textColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              NavigationBarButton(
                text: 'Settings',
                icon: Icons.settings_outlined,
                textColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
            onTabChange: (index) {
              if (state is LoadingNews && index == 1) {
              } else {
                AppCubit.get(context).changeIndex(index);
              }
            },
          ),
          body: AppCubit.get(context).screens[AppCubit.get(context).navIndex],
        );
      },
    );
  }
}
