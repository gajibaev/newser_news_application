import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_application/articles/models/models.dart';
import 'package:news_application/utils/load_info.dart';
import 'package:news_application/utils/months.dart';
import 'package:news_repository/news_repository.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({required newsRepository})
      : _newsRepository = newsRepository,
        super(const ArticlesState(articles: [])) {
    on<ArticlesLoadInfoChanged>(_articleLoadInfoChanged);
    on<LoadArticlesBySectionIndex>(_onLoadSectionArticlesBySectionIndex);
    on<LoadArticlesBySectionName>(_onLoadSectionArticlesBySectionName);
    on<SelectArticle>(_onSelectedArticle);
  }

  final NewsRepository _newsRepository;
  final Logger logger = Logger();

  void _onSelectedArticle(
    SelectArticle event,
    Emitter<ArticlesState> emit,
  ) {
    emit(state.copyWith(selectedArticleTitle: event.articleTitle));
  }

  void _onLoadSectionArticlesBySectionIndex(
    LoadArticlesBySectionIndex event,
    Emitter<ArticlesState> emit,
  ) async {
    await _onLoadSectionArticles(
        _getSectionNameByIndex(event.sectionIndex), emit);
  }

  void _onLoadSectionArticlesBySectionName(
    LoadArticlesBySectionName event,
    Emitter<ArticlesState> emit,
  ) async {
    await _onLoadSectionArticles(event.sectionName, emit);
  }

  Future<void> _onLoadSectionArticles(
    String sectionName,
    Emitter<ArticlesState> emit,
  ) async {
    add(ArticlesLoadInfoChanged(LoadInfo.load));
    await _getArticles(sectionName).then(
      (value) {
        emit.call(state.copyWith(articles: _getArticlesData(value.articles)));
        add(ArticlesLoadInfoChanged(LoadInfo.loaded));
      },
    ).onError((error, stackTrace) {
      add(ArticlesLoadInfoChanged(LoadInfo.error));
    });
  }

  void _articleLoadInfoChanged(
    ArticlesLoadInfoChanged event,
    Emitter<ArticlesState> emit,
  ) async {
    if (event.info.status == LoadStatus.load) {
      emit.call(state.copyWith(loadInfo: event.info));
    } else if (event.info.status == LoadStatus.notLoaded) {
      emit.call(state.copyWith(loadInfo: event.info));
    } else if (event.info.status == LoadStatus.loaded) {
      emit.call(state.copyWith(loadInfo: event.info));
    } else if (event.info.status == LoadStatus.error) {
      emit.call(state.copyWith(loadInfo: event.info));
    }
    logger.i(
        'Articles load status changed: ${event.info.status} with message: ${event.info.message}');
  }

  Future<SectionArticles> _getArticles(
    String section,
  ) async {
    return await _newsRepository
        .getSectionArticles(section)
        .onError((error, stackTrace) {
      throw Exception(error);
    });
  }

  List<ArticleData> _getArticlesData(List<Article> articles) {
    return articles
        .map(
          (e) => ArticleData(
            title: e.title,
            slugName: e.slug_name,
            section: e.section,
            subsection: e.subsection,
            url: e.url,
            subheadline: e.subhead_line,
            source: e.source,
            publishedDate: _formateDateFromString(e.published_date),
            multimedia: _getMultimediaData(e.multimedia),
            abstract_: e.abstract_,
            byline: e.byline,
          ),
        )
        .toList();
  }

  final DateFormat formatter = DateFormat('yyyy-mm-ddThh:mm:ss');

  String? _formateDateFromString(String? date) {
    if (date != null) {
      final parsed = formatter.parse(date);
      final formatted =
          '${Months.getMonthName(parsed.month)} ${parsed.day} ${parsed.year} • ${_formateNumberLessTen(parsed.hour)}:${_formateNumberLessTen(parsed.minute)}';
      return formatted;
    } else {
      return '';
    }
  }

  String _formateNumberLessTen(int number) {
    if (number < 10) {
      return '0$number';
    } else {
      return number.toString();
    }
  }

  String _getSectionNameByIndex(int index) {
    String? section = _newsRepository.getSections[index].section;
    return section ?? 'world';
  }

  List<MultimediaData>? _getMultimediaData(List<Multimedia>? multimedia) {
    if (multimedia != null) {
      return multimedia
          .map(
            (e) => MultimediaData(
              url: e.url,
              format: e.format,
              height: e.height,
              width: e.width,
              type: e.type,
              subtype: e.subtype,
              caption: e.caption,
              copyright: e.copyright,
            ),
          )
          .toList();
    } else {
      return null;
    }
  }
}
