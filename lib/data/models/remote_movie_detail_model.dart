import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:cits_movie_app/data/http/http.dart';

import 'package:cits_movie_app/domain/entities/entities.dart';

class RemoteMoviesModel extends Equatable {
  final int id;
  final String overview;
  final double voteAverage;
  final String posterPath;
  final String releaseDate;
  final String title;

  RemoteMoviesModel({
    @required this.id,
    @required this.overview,
    @required this.voteAverage,
    @required this.posterPath,
    @required this.releaseDate,
    @required this.title,
  });

  factory RemoteMoviesModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'id',
      'overview',
      'vote_average',
      'poster_path',
      'release_date',
      'title'
    ])) {
      throw HttpError.invalidData;
    }

    return RemoteMoviesModel(
        id: json['id'],
        overview: json['overview'],
        voteAverage: json['voteAverage'] == null ? 0.0 : json['voteAverage'].toDouble(),
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title']);
  }

  MoviesEntity toEntity() => MoviesEntity(
        id: id,
        overview: overview,
        voteAverage: voteAverage,
        posterPath: posterPath,
        releaseDate: DateTime.parse(releaseDate),
        title: title,
      );

  @override
  // TODO: implement props
  List get props =>
      ['id', 'overview', 'voteAverage', 'posterPath', 'releaseDate', 'title'];
}
