import '../../data/models/models.dart';

import '../../domain/usecases/load_movies.dart';

abstract class MoviesPresenter{
  Stream<bool> get isLoadingStream;
  Stream<List<RemoteMoviesModel>> get moviesStream;

  Future<void> loadData(LoadMoviesParams params);
  void goToMovieDetails(String surveyId);

}