import 'package:cits_movie_app/data/models/models.dart';
import 'package:cits_movie_app/domain/usecases/load_movies.dart';

abstract class MoviesPresenter{
  Stream<bool> get isLoadingStream;
  Stream<List<RemoteMoviesModel>> get moviesStream;

  Future<void> loadData(LoadMoviesParams params);

}