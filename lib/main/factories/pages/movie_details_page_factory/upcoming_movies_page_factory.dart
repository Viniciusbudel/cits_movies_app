import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../../data/usecases/usecases.dart';

import '../../../../presentation/presenters/presenters.dart';

import '../../../../infra/http/http.dart';

import '../../../../ui/pages/pages.dart';


Widget makeMovieDetailPage() {
  final url = 'https://api.themoviedb.org/3/movie/';
  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteLoadMovieDetails =
      RemoteLoadMovieDetails(url: url, httpClient: httpAdapter);

  final getxMovieDetailsPresenter = GetxMovieDetailsPresenter(loadMovieDetail:  remoteLoadMovieDetails,movieId: Get.parameters['movie_id']);

  return MovieDetailPage(getxMovieDetailsPresenter);
}
