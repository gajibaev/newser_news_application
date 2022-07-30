import 'package:flutter/material.dart';
import 'package:news_application/app.dart';
import 'package:news_repository/news_repository.dart';

void main() {
  runApp(App(newsRepository: NewsRepository()));
}
