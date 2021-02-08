import 'package:cits_movie_app/domain/usecases/load_movies.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMovies implements LoadMovies{
  final String url;
  final HttpClient httpClient;

  RemoteLoadMovies({
    @required this.url,
    @required this.httpClient,
  });

  @override
  Future<List<MoviesEntity>> load({LoadMoviesParams params}) async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      final teste = httpResponse['results'];
      return httpResponse['results']
          .map<MoviesEntity>(
              (json) => RemoteMoviesModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }


}
