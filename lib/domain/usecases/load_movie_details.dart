import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

abstract class LoadMovieDetail {
  Future<List<MovieDetailEntity>> load({@required int id});
}

