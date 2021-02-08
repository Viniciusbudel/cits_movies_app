import 'package:cits_movie_app/data/models/models.dart';
import 'package:cits_movie_app/domain/usecases/load_movie_details.dart';
import 'package:cits_movie_app/domain/usecases/load_movies.dart';

abstract class MoviesDetailPresenter{
  Stream<bool> get isLoadingStream;
  Stream<List<RemoteMoviesModel>> get movieDetailStream;

  Future<void> loadData(LoadMovieDetailParams params);

}