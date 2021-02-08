import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../data/models/models.dart';

import '../../presentation/presenters/presenters.dart';
import '../../presentation/mixins/navigation_manager.dart';

import '../../ui/helpers/errors/ui_error.dart';

class GetxMoviesPresenter extends GetxController
    with NavigationManager
    implements MoviesPresenter {
  final LoadMovies loadMovies;
  final _isLoading = true.obs;
  final _movies = Rx<List<RemoteMoviesModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;

  Stream<List<RemoteMoviesModel>> get moviesStream => _movies.stream;

  GetxMoviesPresenter({@required this.loadMovies});

  Future<void> loadData(LoadMoviesParams params) async {
    try {
      _isLoading.value = true;

      final movies = await loadMovies.load(params: params);
      _movies.value = movies
          .map((movie) => RemoteMoviesModel(
              id: movie.id,
              overview: movie.overview,
              voteAverage: movie.voteAverage,
              posterPath: movie.posterPath,
              releaseDate:
                  DateFormat('dd MMM yyyy', 'pt_Br').format(movie.releaseDate),
              title: movie.title))
          .toList();
    } on DomainError {
      _movies.subject.addError(UIError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }

  void goToMovieDetails(String movieId) {
    navigateTo = '/movie_details/$movieId';
  }
}
