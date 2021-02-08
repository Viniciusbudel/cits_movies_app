import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../data/models/models.dart';
import '../../data/models/remote_movie_detail_model.dart';

import '../../ui/helpers/errors/ui_error.dart';

import '../../presentation/presenters/presenters.dart';

class GetxMovieDetailsPresenter implements MoviesDetailPresenter {
  final LoadMovieDetails loadMovieDetail;
  final _isLoading = true.obs;
  final String movieId;

  final _movies = Rx<RemoteMovieDetailModel>();

  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxMovieDetailsPresenter({
    @required this.loadMovieDetail,
    @required this.movieId,
  });

  @override
  Stream<RemoteMovieDetailModel> get movieDetailStream =>  _movies.stream;

  @override
  Future<void> loadData(LoadMovieDetailParams params) async {
    try {
      _isLoading.value = true;

      final movie = await loadMovieDetail.load(params: params, id: movieId);

      _movies.value = RemoteMovieDetailModel(
        id: movie.id,
        overview: movie.overview,
        voteAverage: movie.voteAverage,
        posterPath: movie.posterPath,
        releaseDate: DateFormat('dd MMM yyyy').format(movie.releaseDate),
        popularity: movie.popularity,
        backdropPath: movie.backdropPath,
        budget: movie.budget,
        genres: movie.genres,
        revenue: movie.revenue,
        title: movie.title,
        runtime: movie.runtime,
      );

    } on DomainError {
      _movies.subject.addError(UIError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }
}
