import 'package:cits_movie_app/data/models/models.dart';

abstract class MoviesPresenter{
  Stream<bool> get isLoadingStream;
  Stream<RemoteMoviesModel> get moviesStream;

  Future<void> loadData();

}