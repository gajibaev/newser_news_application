import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:news_application/utils/utils.dart';
import 'package:news_repository/news_repository.dart';
import 'package:news_application/sections/models/models.dart';
import 'package:logger/logger.dart';

part 'sections_event.dart';
part 'sections_state.dart';

class SectionsBloc extends Bloc<SectionsEvent, SectionsState> {
  SectionsBloc({required newsRepository})
      : _newsRepository = newsRepository,
        super(const SectionsState()) {
    on<LoadSections>(_onLoadSections);
    on<SectionsLoadStatusChanged>(_sectionsLoadStatusChanged);
  }

  final NewsRepository _newsRepository;
  final Logger logger = Logger();

  void _onLoadSections(
    LoadSections event,
    Emitter<SectionsState> emit,
  ) async {
    _sectionsLoadStatusChanged(SectionsLoadStatusChanged(LoadInfo.load), emit);
    await _getSections().then(
      (sections) {
        emit.call(
          state.copyWith(sections: _getSectionsData(sections)),
        );
        _sectionsLoadStatusChanged(
            SectionsLoadStatusChanged(LoadInfo.loaded), emit);
      },
    ).onError<FormatException>((error, stackTrace) {
      _sectionsLoadStatusChanged(
          SectionsLoadStatusChanged(
              LoadInfo.error.copyWith(message: error.message)),
          emit);
    });
  }

  void _sectionsLoadStatusChanged(
    SectionsLoadStatusChanged event,
    Emitter<SectionsState> emit,
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
        'Sections load status changed: ${event.info.status} with message: ${event.info.message}');
  }

  Future<List<Section>> _getSections() async {
    return await _newsRepository.getSectionsFromServer();
  }

  List<SectionData> _getSectionsData(List<Section> sections) {
    return sections
        .map(
          (e) => SectionData(e.section ?? 'section don`t loaded',
              e.display_name ?? 'section don`t loaded'),
        )
        .toList();
  }
}
