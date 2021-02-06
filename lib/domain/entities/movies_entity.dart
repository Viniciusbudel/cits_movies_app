import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MoviesEntity extends Equatable {
  final int id;
  final String overview;
  final double voteAverage;
  final String posterPath;
  final DateTime releaseDate;
  final String title;

  List get props => [
    'id',
    'overview',
    'voteAverage',
    'posterPath',
    'releaseDate',
    'title',
  ];

  MoviesEntity(
      {@required this.id,
      @required this.overview,
      @required this.voteAverage,
      @required this.posterPath,
      @required this.releaseDate,
      @required this.title});


}
