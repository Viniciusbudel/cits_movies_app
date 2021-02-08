import 'package:cits_movie_app/data/models/models.dart';
import 'package:cits_movie_app/domain/usecases/load_movies.dart';

abstract class MoviesDetailsPresenter{
  Stream<bool> get isLoadingStream;
  Stream<List<RemoteMoviesModel>> get movieDetailStream;

  Future<void> loadData(int id);

}