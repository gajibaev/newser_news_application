import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/routes.dart';
import 'package:news_application/sections/sections.dart';
import 'package:news_application/splash/view/splash_page.dart';
import 'package:news_repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:theme_provider/theme_provider.dart';

import 'articles/articles.dart';
import 'utils/utils.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.newsRepository,
  }) : super(key: key);

  final NewsRepository newsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: newsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final BehaviorSubject<String> startTheme = BehaviorSubject.seeded('light');

  final ThemeData lightTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    cardColor: Colors.black,
    brightness: Brightness.light,
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(color: Colors.grey),
          bodyMedium: const TextStyle(color: Colors.black),
          bodySmall: const TextStyle(color: Colors.white),
        ),
  );

  final ThemeData darkTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.black,
    cardColor: Colors.white,
    brightness: Brightness.dark,
    textTheme: ThemeData.dark().textTheme.copyWith(
          bodyLarge: const TextStyle(color: Colors.grey),
          bodyMedium: const TextStyle(color: Colors.white),
          bodySmall: const TextStyle(color: Colors.black),
        ),
  );

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    _getStartTheme();

    WidgetsBinding.instance!.addObserver(LifecycleEventHandler(
        resumeCallBack: () async => setState(() {
              _getStartTheme();
            })));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: startTheme,
        builder: (context, snapshot) {
          return ThemeProvider(
            themes: [
              AppTheme(id: 'light', data: lightTheme, description: ''),
              AppTheme(id: 'dark', data: darkTheme, description: ''),
            ],
            defaultThemeId: snapshot.data,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<SectionsBloc>(
                  create: (_) => SectionsBloc(
                    newsRepository:
                        RepositoryProvider.of<NewsRepository>(context),
                  ),
                ),
                BlocProvider<ArticlesBloc>(
                  create: (_) => ArticlesBloc(
                    newsRepository:
                        RepositoryProvider.of<NewsRepository>(context),
                  ),
                ),
              ],
              child: ThemeConsumer(
                child: Builder(
                  builder: (context) {
                    ThemeData themeData = ThemeProvider.themeOf(context).data;
                    _setStatusBarStyle(themeData);
                    return MaterialApp(
                      theme: themeData,
                      navigatorKey: _navigatorKey,
                      debugShowCheckedModeBanner: false,
                      onGenerateRoute: (settings) {
                        if (settings.name == "/") {
                          return Routes.fadeRoute(
                            const SplashPage(),
                            direction: AxisDirection.right,
                            curve: Curves.easeInOutSine,
                            duration: const Duration(milliseconds: 500),
                          );
                        } else if (settings.name == "sections") {
                          return Routes.fadeRoute(
                            const SectionsPage(),
                            direction: settings.arguments as AxisDirection,
                            curve: Curves.easeInOutSine,
                            duration: const Duration(milliseconds: 500),
                          );
                        } else if (settings.name == "articles") {
                          return Routes.fadeRoute(
                            const ArticlesPage(),
                            direction: AxisDirection.left,
                            curve: Curves.easeInOutSine,
                            duration: const Duration(milliseconds: 500),
                          );
                        } else if (settings.name == "article" &&
                            settings.arguments is ArticleData) {
                          return Routes.fadeRoute(
                            ArticlePage(
                              data: settings.arguments as ArticleData,
                            ),
                            direction: AxisDirection.left,
                            curve: Curves.easeInOutSine,
                            duration: const Duration(milliseconds: 500),
                          );
                        }
                        return null;
                      },
                      routes: {
                        '/': (context) => const SplashPage(),
                        '/sections': (context) => const SectionsPage(),
                        '/articles': (context) => const ArticlesPage(),
                        '/article': (context) =>
                            ArticlePage(data: ArticleData()),
                      },
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  void _getStartTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? themeName;
    if (prefs.containsKey(LaunchData.themeNameKey)) {
      themeName = prefs.getString(LaunchData.themeNameKey);
    }

    startTheme.add(themeName ?? 'light');
  }

  void _setStatusBarStyle(ThemeData themeData) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarIconBrightness:
            themeData.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
    await StatusBarControl.setColor(themeData.backgroundColor);
    await StatusBarControl.setStyle(themeData.brightness == Brightness.dark
        ? StatusBarStyle.LIGHT_CONTENT
        : StatusBarStyle.DARK_CONTENT);
    await StatusBarControl.setNavigationBarColor(themeData.backgroundColor);
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}
