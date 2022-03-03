import 'package:url_launcher/url_launcher.dart';

void openURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
