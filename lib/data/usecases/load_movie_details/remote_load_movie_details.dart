import 'package:cits_movie_app/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMovieDetails implements LoadMovieDetail {
  final String url;
  final HttpClient httpClient;

  RemoteLoadMovieDetails({
    @required this.url,
    @required this.httpClient,
  });

  @override
  Future<List<MovieDetailEntity>> load({LoadMovieDetailParams params}) async {
    try {
      String urlFinal = _handleQueryParams(params);

      final httpResponse =
          await httpClient.request(url: urlFinal, method: 'get');

      return httpResponse
          .map<MoviesEntity>(
              (json) => RemoteMoviesModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }

  String _handleQueryParams(LoadMovieDetailParams params) {
    String urlFinal = '$url/${params.id}';
    urlFinal = '$url?api_key=${params.apiKey}';

    if (params.language != null) {
      urlFinal = '$urlFinal&language=${params.language}';
    } else {
      urlFinal = '$urlFinal&language=pt-BR';
    }

    return urlFinal;
  }
}
