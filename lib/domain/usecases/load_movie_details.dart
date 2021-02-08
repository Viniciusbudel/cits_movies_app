import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

abstract class LoadMovieDetails {
  Future<List<MovieDetailEntity>> load(
      {@required LoadMovieDetailParams params, @required String id});
}

class LoadMovieDetailParams {
  final String apiKey;
  final String language;
  final String region;

  LoadMovieDetailParams({
    @required this.apiKey,
    this.language,
    this.region,
  });
}
