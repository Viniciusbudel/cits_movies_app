import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';

class RowMovieDetails extends StatelessWidget {
  final RemoteMovieDetailModel movie;

  RowMovieDetails({
    @required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          movie.releaseDate,
          style: Theme
              .of(context)
              .textTheme
              .subtitle2,
        ),
        VerticalDivider(),
        Text(
          '${movie.runtime.toString()} minutos',
          style: Theme
              .of(context)
              .textTheme
              .subtitle2,
        ),
        VerticalDivider(
          color: Colors.white,
        ),
        Text(
          'Nota: ${movie.voteAverage}',
          style: Theme
              .of(context)
              .textTheme
              .subtitle2,
        ),
      ],
    );
  }
}
