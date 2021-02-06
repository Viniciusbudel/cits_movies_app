import 'package:cits_movie_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../data/usecases/load_movies/load_movies.dart';
import '../../../../infra/http/http.dart';

Widget makeUpcomingMoviesPage() {
  final url = 'http://fordevs.herokuapp.com/api/login';
  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteLoadMovies =
      RemoteLoadMovies(url: url, httpClient: httpAdapter);

  // final streamLoginPresenter = StreamLoginPresenter(
  //     authentication: remoteAuthetication, validation: validationComposite);
  return UpcomingMoviesPage();
}
