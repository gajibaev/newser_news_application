import 'package:flutter/material.dart';
import 'package:news_application/utils/launch_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:theme_provider/theme_provider.dart';

class ThemeChanger extends StatefulWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {
  PublishSubject<bool> flag = PublishSubject();
  late Stream<bool> debounceStream;
  @override
  void initState() {
    debounceStream = flag.debounceTime(
      const Duration(milliseconds: 250),
    );
    debounceStream.listen(
      (event) async {
        ThemeProvider.controllerOf(context).nextTheme();

        var prefs = await SharedPreferences.getInstance();
        prefs.setString(LaunchData.themeNameKey,
            ThemeProvider.controllerOf(context).currentThemeId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 30,
      height: 30,
      child: StreamBuilder<bool>(
          stream: debounceStream,
          builder: (context, snapshot) {
            var value = snapshot.data ?? false;
            return IconButton(
              padding: EdgeInsets.zero,
              splashColor: Colors.transparent,
              onPressed: () {
                flag.add(!value);
              },
              icon: Icon(
                theme.brightness == Brightness.dark
                    ? Icons.brightness_7
                    : Icons.brightness_2,
                color: theme.cardColor,
              ),
            );
          }),
    );
  }
}
