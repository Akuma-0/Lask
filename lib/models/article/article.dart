import 'package:hive/hive.dart';

part 'article.g.dart'; // This file will be generated by Hive

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  String author;

  @HiveField(1)
  String title;

  @HiveField(2)
  String url;

  @HiveField(3)
  String image;

  @HiveField(4)
  String date;

  @HiveField(5)
  bool isSaved;

  Article({
    required this.author,
    required this.title,
    required this.url,
    required this.image,
    required this.date,
    this.isSaved = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      image: json['urlToImage'] ?? '',
      date: json['publishedAt'] ?? '',
    );
  }

  @override
  int get hashCode => url.hashCode;
}
