enum LoadStatus {
  notLoaded,
  load,
  loaded,
  error,
}

enum LoadError {
  unknown,
  internetConnection,
  manyRequest,
}

class LoadInfo {
  const LoadInfo(this.status, {this.message = ''});

  static const LoadInfo notLoaded = LoadInfo(LoadStatus.notLoaded, message: '');
  static const LoadInfo load = LoadInfo(LoadStatus.load, message: '');
  static const LoadInfo loaded = LoadInfo(LoadStatus.loaded, message: '');
  static const LoadInfo error = LoadInfo(LoadStatus.error, message: '');

  final LoadStatus status;
  final dynamic message;

  LoadInfo copyWith({
    LoadStatus? status,
    dynamic message,
  }) {
    return LoadInfo(
      status ?? this.status,
      message: message ?? this.message,
    );
  }
}
