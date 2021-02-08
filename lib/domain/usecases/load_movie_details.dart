import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

abstract class LoadMovieDetails {
  Future<List<MovieDetailEntity>> load({@required LoadMovieDetailParams params});
}

class LoadMovieDetailParams {
  final String apiKey;
  final String language;
  final String id;
  final String region;

  LoadMovieDetailParams({
    @required this.apiKey,
    this.language,
    this.id,
    this.region,
  });
}
