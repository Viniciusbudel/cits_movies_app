import 'package:cits_movie_app/presentation/presenters/getx_movies_presenter.dart';
import 'package:cits_movie_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../data/usecases/load_movies/load_movies.dart';
import '../../../../infra/http/http.dart';

Widget makeUpcomingMoviesPage() {
  final url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=7c130c4d6b5a83e1a0223a8cbf26b27a&language=pt-BR&page=1';
  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteLoadMovies =
      RemoteLoadMovies(url: url, httpClient: httpAdapter);

  final getxMoviesPresenter = GetxMoviesPresenter(loadMovies: remoteLoadMovies);
  return UpcomingMoviesPage(getxMoviesPresenter);
}
