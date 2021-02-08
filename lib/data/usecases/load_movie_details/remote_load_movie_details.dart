import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMovieDetails implements LoadMovieDetails {
  final String url;
  final HttpClient httpClient;

  RemoteLoadMovieDetails({
    @required this.url,
    @required this.httpClient,
  });

  @override
  Future<List<MovieDetailEntity>> load(
      {LoadMovieDetailParams params, String id}) async {
    try {
      String urlFinal = _handleQueryParams(params, id);

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

  String _handleQueryParams(LoadMovieDetailParams params, String id) {
    String urlFinal = '$url/$id';
    urlFinal = '$url?api_key=${params.apiKey}';

    if (params.language != null) {
      urlFinal = '$urlFinal&language=${params.language}';
    } else {
      urlFinal = '$urlFinal&language=pt-BR';
    }

    return urlFinal;
  }
}
