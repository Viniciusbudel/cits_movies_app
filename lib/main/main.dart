import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../ui/components/app_theme.dart';
import '../main/factories/pages/upcoming_movies/upcoming_movies_page_factory.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'cits_movies_app',
      theme: makeAppTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'upcoming_movies',
      getPages: [
        GetPage(name: '/upcoming_movies', page: makeUpcomingMoviesPage)
      ],
    );
  }
}
