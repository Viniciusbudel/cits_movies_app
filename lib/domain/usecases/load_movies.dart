import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

abstract class LoadMovies {
  Future<List<MoviesEntity>> load({@required LoadMoviesParams params});
}

class LoadMoviesParams {
  final String apiKey;
  final String language;
  final String page;
  final String region;

  LoadMoviesParams({
    @required this.apiKey,
    this.language,
    this.page,
    this.region,
  });
}
