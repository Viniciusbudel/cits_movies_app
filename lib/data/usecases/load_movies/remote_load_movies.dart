import 'package:meta/meta.dart';
import 'package:cits_movie_app/data/http/http.dart';
import 'package:cits_movie_app/data/models/models.dart';
import 'package:cits_movie_app/domain/entities/entities.dart';
import 'package:cits_movie_app/domain/helpers/helpers.dart';


class RemoteLoadMovies {
  final String url;
  final HttpClient httpClient;

  RemoteLoadMovies({
    @required this.url,
    @required this.httpClient,
  });

  Future<List<MoviesEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<MoviesEntity>((json) => RemoteMoviesModel.fromJson(json).toEntity()).toList();




    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}