part of 'sections_bloc.dart';

abstract class SectionsEvent {}

class LoadSections extends SectionsEvent {}

class SectionsLoadStatusChanged extends SectionsEvent {
  SectionsLoadStatusChanged(this.info);

  final LoadInfo info;
}
