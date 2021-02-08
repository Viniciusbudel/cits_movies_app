import 'package:cits_movie_app/data/usecases/load_movies/load_movies.dart';
import 'package:cits_movie_app/domain/usecases/load_movies.dart';

LoadMovies makeRemoteLoadMovies(){
  return RemoteLoadMovies(url: null, httpClient: null);
}