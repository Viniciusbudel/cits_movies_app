import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MovieDetailEntity {
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

  MovieDetailEntity(
      {this.backdropPath,
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
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
