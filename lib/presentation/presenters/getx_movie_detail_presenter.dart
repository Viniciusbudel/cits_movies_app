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

  final _movies = Rx<List<RemoteMovieDetailModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;

  Stream<List<RemoteMovieDetailModel>> get moviesStream => _movies.stream;

  GetxMovieDetailsPresenter({@required this.loadMovieDetail,@required this.movieId,});

  @override
  // TODO: implement movieDetailStream
  Stream<List<RemoteMoviesModel>> get movieDetailStream =>
      throw UnimplementedError();

  @override
  Future<void> loadData(LoadMovieDetailParams params) async {
    try {
      _isLoading.value = true;

      final movies = await loadMovieDetail.load(params: params);
      _movies.value = movies
          .map((movie) => RemoteMovieDetailModel(
                id: movie.id,
                overview: movie.overview,
                voteAverage: movie.voteAverage,
                posterPath: movie.posterPath,
                releaseDate:
                    DateFormat('dd MMM yyyy').format(movie.releaseDate),
                popularity: movie.popularity,
                backdropPath: movie.backdropPath,
                budget: movie.budget,
                genres: movie.genres,
                revenue: movie.revenue,
                title: movie.title,
                runtime: movie.runtime,
              ))
          .toList();
    } on DomainError {
      _movies.subject.addError(UIError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }
}
