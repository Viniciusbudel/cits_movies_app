import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:cits_movie_app/data/http/http.dart';

import 'package:cits_movie_app/domain/entities/entities.dart';

class RemoteMovieDetailModel extends Equatable {
  String backdropPath;
  int budget;
  List<Genres> genres;
  int id;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  int revenue;
  int runtime;
  String title;
  double voteAverage;

  RemoteMovieDetailModel({
    this.backdropPath,
    this.budget,
    this.genres,
    this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.title,
    this.voteAverage,
  });

  List get props => [
        'id',
        'overview',
        'voteAverage',
        'posterPath',
        'releaseDate',
        'backdropPath',
        'budget',
        'genres',
        'popularity',
        'revenue',
        'runtime',
      ];

  factory RemoteMovieDetailModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'id',
      'overview',
      'voteAverage',
      'posterPath',
      'releaseDate',
      'backdropPath',
      'budget',
      'genres',
      'popularity',
      'revenue',
      'runtime',
    ])) {
      throw HttpError.invalidData;
    }

    return RemoteMovieDetailModel(
        id: json['id'],
        overview: json['overview'],
        voteAverage:
            json['voteAverage'] == null ? 0.0 : json['voteAverage'].toDouble(),
        posterPath: json['poster_path'],
        budget: json['budget'],
        releaseDate: json['release_date'],
        genres: json['genres'],
        popularity: json['popularity'],
        revenue: json['revenue'],
        runtime: json['runtime'],
        title: json['title']);
  }

  MovieDetailEntity toEntity() => MovieDetailEntity(
        id: id,
        overview: overview,
        voteAverage: voteAverage,
        posterPath: posterPath,
        releaseDate: DateTime.parse(releaseDate),
        genres: genres,
        popularity: popularity,
        revenue: revenue,
        runtime: runtime,
        title: title,
      );
}
