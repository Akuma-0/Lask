import 'package:dio/dio.dart';

import '../models/weather/city.dart';
import '../models/weather/weather_data.dart';

class ApiServices {
  static var _newsKey = '57a10b7027284423a0cae1bd681dc67a';
  static var _weatherKey = '607a0a1463ae3b3ef9eadedc55c6617e';
  static Dio dio = Dio();
  static Future<Map<String, dynamic>?> fetchTopHeadLines() async {
    /*
    *https://newsapi.org/v2/top-headlines
    * ?country=eg
    * &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchBusiness() async {
    /*
    GET https://newsapi.org/v2/top-headlines?
    country=eg
    &category=business
    &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'business',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchEntertainment() async {
    /*
    GET https://newsapi.org/v2/top-headlines?
    country=eg
    &category=entertainment
    &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'entertainment',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchGeneral() async {
    /*
    GET https://newsapi.org/v2/top-headlines?
    country=eg
    &category=general
    &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'general',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchHealth() async {
    /*
    GET https://newsapi.org/v2/top-headlines?
    country=eg
    &category=health
    &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'health',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchScience() async {
    /*
    GET https://newsapi.org/v2/top-headlines?
    country=eg
    &category=science
    &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'science',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchSports() async {
    /*
    GET https://newsapi.org/v2/top-headlines?
    country=eg
    &category=sports
    &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchTechnology() async {
    /*
    GET https://newsapi.org/v2/top-headlines?
    country=eg
    &category=technology
    &apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'technology',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> fetchSearch(String query) async {
    /*
    GET https://newsapi.org/v2/everything?
    q=Apple&
    from=2024-08-20&
    sortBy=popularity&
    apiKey=a9936913cd4e4129b71d98541f62436f
     */
    var response = await dio.get(
      'https://newsapi.org/v2/everything',
      queryParameters: {
        'q': query,
        'sortBy': 'popularity',
        'apiKey': _newsKey,
      },
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.toString());
      return null;
    }
  }

  static Future<List<City>> fetchCities(String name) async {
    const String url = 'https://api.openweathermap.org/geo/1.0/direct';
    const int limit = 10;

    try {
      Dio dio = Dio();
      final response = await dio.get(url, queryParameters: {
        'q': name,
        'limit': limit,
        'appid': _weatherKey,
      });

      if (response.statusCode == 200) {
        List<City> cities = (response.data as List)
            .map((cityJson) => City.fromJson(cityJson))
            .toList();
        return cities;
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching cities');
    }
  }

  static Future<WeatherData?> fetchWeatherData(City city) async {
    try {
      var baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
      Dio dio = Dio();
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          'lat': city.lat,
          'lon': city.lon,
          'units': 'metric',
          'appid': _weatherKey,
        },
      );

      if (response.statusCode == 200) {
        WeatherData weatherData = WeatherData.fromJson(response.data);
        return weatherData;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching weather data');
    }
  }
}
