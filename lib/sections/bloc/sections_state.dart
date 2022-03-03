part of 'sections_bloc.dart';

class SectionsState {
  const SectionsState({
    this.sections = const [],
    this.loadInfo = LoadInfo.notLoaded,
  });

  final LoadInfo loadInfo;

  final List<SectionData>? sections;

  SectionsState copyWith({
    LoadInfo? loadInfo,
    List<SectionData>? sections,
  }) {
    return SectionsState(
      loadInfo: loadInfo ?? this.loadInfo,
      sections: sections ?? this.sections,
    );
  }
}
