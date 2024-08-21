import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lask/models/article/news_reponse.dart';
import 'package:lask/modules/bookmarks_screen/bookmarks_screen.dart';
import 'package:lask/modules/explore_screen/explore_screen.dart';
import 'package:lask/modules/setting_screen/setting_screen.dart';
import 'package:lask/shared/api_services.dart';
import '../../../models/article/article.dart';
import '../../../models/weather/city.dart';
import '../../../modules/home_screen/home_screen.dart';
import '../hive/hive_helper.dart';

part 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  var navIndex = 0;
  NewsResponse? topHeadlines;
  NewsResponse? business;
  NewsResponse? general;
  NewsResponse? science;
  NewsResponse? sports;
  NewsResponse? search;
  NewsResponse? technology;
  NewsResponse? health;
  NewsResponse? entertainment;
  var theme;
  var city;
  var cities;
  var savedArticles = saved!.get('articlesMap') ?? {};
  var screens = [
    HomeScreen(),
    ExploreScreen(),
    BookmarksScreen(),
    SettingScreen(),
  ];
  var titles = [
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (DateTime.now().hour > 7 && DateTime.now().hour < 19)
            ? Text(
                'Good morning',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              )
            : Text(
                'Good evening',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
        Text(
          '${DateFormat.yMMMEd().format(DateTime.now())}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    Text(
      "Explore",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      "Bookmark",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      "Settings",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  var weather;
  Future<void> changeIndex(index) async {
    navIndex = index;
    if (index == 1 &&
        business == null &&
        entertainment == null &&
        general == null &&
        health == null &&
        science == null &&
        sports == null &&
        technology == null) {
      emit(LoadingNews());
      await businessMaker();
      await entertainmentMaker();
      await generalMaker();
      await healthMaker();
      await scienceMaker();
      await sportsMaker();
      await technologyMaker();
      emit(Done());
    }

    emit(ChangeIndex());
  }

  Future topHeadlinesMaker() async {
    emit(LoadingTopNews());
    topHeadlines = await NewsResponse.fromJson(
        await ApiServices.fetchTopHeadLines() ?? {});
    emit(TopHeadlinesDone());
  }

  Future businessMaker() async {
    business =
        await NewsResponse.fromJson(await ApiServices.fetchBusiness() ?? {});
  }

  Future entertainmentMaker() async {
    entertainment = await NewsResponse.fromJson(
        await ApiServices.fetchEntertainment() ?? {});
  }

  Future generalMaker() async {
    general =
        await NewsResponse.fromJson(await ApiServices.fetchGeneral() ?? {});
  }

  Future healthMaker() async {
    health = await NewsResponse.fromJson(await ApiServices.fetchHealth() ?? {});
  }

  Future scienceMaker() async {
    science =
        await NewsResponse.fromJson(await ApiServices.fetchScience() ?? {});
  }

  Future sportsMaker() async {
    sports = await NewsResponse.fromJson(await ApiServices.fetchSports() ?? {});
  }

  Future technologyMaker() async {
    technology =
        await NewsResponse.fromJson(await ApiServices.fetchTechnology() ?? {});
  }

  Future searchMaker(String query) async {
    emit(LoadingSearch());
    search =
        await NewsResponse.fromJson(await ApiServices.fetchSearch(query) ?? {});
    emit(SearchDone());
  }

  Future cityMaker(String city) async {
    emit(LoadingCities());
    cities = await ApiServices.fetchCities(city) ?? [];
    emit(CitiesDone());
  }

  Future weatherMaker() async {
    if (city == null) return null;
    emit(LoadingWeather());
    weather = await ApiServices.fetchWeatherData(city) ?? null;
    emit(WeatherDone());
  }

  void changeTheme(theme) {
    data!.put('theme', theme);
    themeFromHive();
    emit(ChangeMode());
  }

  void changeCity(City city) {
    data!.put('cityName', city.name);
    data!.put('lat', city.lat);
    data!.put('lon', city.lon);
    data!.put('country', city.country);
    cityFromHive();
    weatherMaker();
    emit(ChangeCity());
  }

  void cityFromHive() {
    city = (data!.get('cityName') == null)
        ? null
        : City(
            name: data!.get('cityName'),
            lat: data!.get('lat'),
            lon: data!.get('lon'),
            state: '',
            country: data!.get('country'),
          );
  }

  void themeFromHive() {
    if (data!.get('theme') == 'ThemeMode.light')
      theme = ThemeMode.light;
    else if (data!.get('theme') == 'ThemeMode.dark')
      theme = ThemeMode.dark;
    else
      theme = ThemeMode.system;
  }

  void saveArticle(Article article) async {
    article.isSaved = true;
    Map<int, Article> savedArticlesMap =
        (saved!.get('articlesMap') as Map?)?.cast<int, Article>() ?? {};
    savedArticlesMap[article.hashCode] = article;
    await saved!.put('articlesMap', savedArticlesMap);

    emit(SaveArticle());
  }

  void removeArticle(Article article) async {
    article.isSaved = false;
    Map<int, Article> savedArticlesMap =
        (saved!.get('articlesMap') as Map?)?.cast<int, Article>() ?? {};
    savedArticlesMap.remove(article.hashCode);
    await saved!.put('articlesMap', savedArticlesMap);
    emit(DeleteArticle());
  }
}
