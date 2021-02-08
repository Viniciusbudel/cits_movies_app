import 'package:cits_movie_app/domain/usecases/load_movies.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMovies implements LoadMovies {
  final String url;
  final HttpClient httpClient;

  RemoteLoadMovies({
    @required this.url,
    @required this.httpClient,
  });

  @override
  Future<List<MoviesEntity>> load({LoadMoviesParams params}) async {
    try {
      String urlFinal = _handleQueryParams(params);

      final httpResponse =
          await httpClient.request(url: urlFinal, method: 'get');

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

  String _handleQueryParams(LoadMoviesParams params) {
    String urlFinal = '$url?api_key=${params.apiKey}';
    if (params.page != null) {
      urlFinal = '$urlFinal&page=${params.page}';
    } else {
      urlFinal = '$urlFinal&page=1';
    }
    if (params.language != null) {
      urlFinal = '$urlFinal&language=${params.language}';
    } else {
      urlFinal = '$urlFinal&language=pt-BR';
    }
    return urlFinal;
  }
}
