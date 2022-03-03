class LaunchData {
  LaunchData(this.loaded, {this.themeName});

  final bool loaded;

  static const String themeNameKey = 'themeName';
  static const String defaultThemeNameValue = 'light';
  final String? themeName;

  LaunchData copyWith(
    bool loaded, {
    String? themeName,
  }) {
    return LaunchData(
      loaded,
      themeName: themeName ?? this.themeName,
    );
  }
}
