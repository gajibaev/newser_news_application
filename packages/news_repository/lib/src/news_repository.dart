import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:news_repository/news_repository.dart';

import 'RestClient.dart';
import 'models/models.dart';

class Source {
  static const String all = 'all';

  static const String nyt = 'nyt';

  static const String inyt = 'inyt';
}

class NewsRepository {
  late List<SectionArticles> _sectionArticles = [];
  late List<Section> _sections = [];

  List<Section> get getSections => _sections;

  final dio = Dio();
  final logger = Logger();

  void _deleteSectionArticlesFromData(String section) {
    _sectionArticles.removeWhere((element) => element.section == section);
  }

  void _putSectionArticlesToData(SectionArticles sectionArticles) {
    if (_dataContainSectionArticles(sectionArticles.section)) {
      _deleteSectionArticlesFromData(sectionArticles.section);
    }

    _sectionArticles.add(sectionArticles);
  }

  SectionArticles? _getSectionArticlesFromData(String section) {
    if (_dataContainSectionArticles(section)) {
      var sectionArticles = _sectionArticles.firstWhere(
        (e) => e.section == section,
        orElse: () {
          return SectionArticles('', [], DateTime.now());
        },
      );

      return sectionArticles;
    }
    return null;
  }

  bool _dataContainSectionArticles(String section) {
    bool contain = true;
    _sectionArticles.firstWhere(
      (e) => e.section == section,
      orElse: () {
        contain = false;
        return SectionArticles('', [], DateTime.now());
      },
    );
    return contain;
  }

  Future<SectionArticles> getSectionArticles(String section) async {
    late SectionArticles? loadedSectionArticles;

    loadedSectionArticles = _getSectionArticlesFromData(section);

    if (loadedSectionArticles != null) {
      if (loadedSectionArticles.loadDate.difference(DateTime.now()).inMinutes >
          1) {
        loadedSectionArticles = await _getSectionArticlesFromServer(section);
      }
    } else {
      loadedSectionArticles = await _getSectionArticlesFromServer(section);
    }

    if (loadedSectionArticles.articles.isNotEmpty) {
      _putSectionArticlesToData(loadedSectionArticles);
    }

    return loadedSectionArticles;
  }

  Future<SectionArticles> _getSectionArticlesFromServer(String section) async {
    SectionArticles loadedSectionArticles;
    var articles =
        await getArticlesFromServer(50, 0, section).catchError((Object obj) {
      logger.log(Level.error, obj.toString());
      throw Exception('error');
      // ! - Слишком частый вызов ошибок
    });
    if (articles != null) {
      loadedSectionArticles = SectionArticles(
        section,
        articles,
        DateTime.now(),
      );
    } else {
      logger.e('articles dont loaded');
      loadedSectionArticles = SectionArticles(
        section,
        [],
        DateTime.now(),
      );
    }
    return loadedSectionArticles;
  }

  Future<List<Article>?> getArticlesFromServer(
      int limit, int offset, String section) async {
    final _client = RestClient(dio,
        baseUrl: "https://api.nytimes.com/svc/news/v3/content/");
    var articleResponse = await _client
        .getArticles(Source.all, section, 'IfIkjNXQBaPVclsYanpWLHGXYXT6OpL0')
        .catchError(
      (obj) {
        logger.log(Level.error, obj.toString());
        if (obj is DioError) {
          throw Exception(obj.response?.statusCode);
        }
      },
    );
    return articleResponse.results!;
  }

  List<Section> _filterSections(List<Section> sections) {
    return sections
        .where((section) =>
            !section.section!.contains('&') && !section.section!.contains('/'))
        .toList();
  }

  Future<List<Section>> getSectionsFromServer() async {
    if (_sections.isNotEmpty) return _sections;
    final _client = RestClient(dio,
        baseUrl: "https://api.nytimes.com/svc/news/v3/content/");
    try {
      await _client
          .getSections('IfIkjNXQBaPVclsYanpWLHGXYXT6OpL0')
          .then((value) {
        _sections = _filterSections(value.results!);
      });
    } on DioError catch (e) {
      if (e.response != null) {
      } else {
        throw const FormatException('No internet connection');
      }
    }
    return _sections;
  }
}
