import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MoviesEntity extends Equatable {
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;

  List get props => [
    'id',
    'overview',
    'popularity',
    'posterPath',
    'releaseDate',
    'title',
  ];

  MoviesEntity(
      {@required this.id,
      @required this.overview,
      @required this.popularity,
      @required this.posterPath,
      @required this.releaseDate,
      @required this.title});


}
