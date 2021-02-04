import 'package:cits_movie_app/domain/entities/entities.dart';
import 'package:meta/meta.dart';

class RemoteMoviesModel {
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;

  RemoteMoviesModel({
    @required this.id,
    @required this.overview,
    @required this.popularity,
    @required this.posterPath,
    @required this.releaseDate,
    @required this.title,
  });

  factory RemoteMoviesModel.fromJson(Map json) {

    return RemoteMoviesModel(
        id: json['id'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['posterPath'],
        releaseDate: json['releaseDate'],
        title: json['title']);

  }

  MoviesEntity toEntity() => MoviesEntity(
        id: id,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: DateTime.parse(releaseDate),
        title: title,
      );
}
