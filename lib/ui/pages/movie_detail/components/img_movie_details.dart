import 'package:flutter/material.dart';

import 'package:cits_movie_app/data/models/models.dart';

import 'circular_clipper.dart';

class ImgMovieDetails extends StatelessWidget {
  const ImgMovieDetails({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final RemoteMovieDetailModel movie;

  @override
  Widget build(BuildContext context) {
    return movie.posterPath?.isNotEmpty == true
        ? Hero(
            tag: movie.id,
            child: ClipShadowPath(
              clipper: CircularClipper(),
              shadow:
                  Shadow(blurRadius: 10, color: Theme.of(context).primaryColor),
              child: Image(
                height: 400,
                color: Color.fromRGBO(255, 255, 255, 0.7),
                colorBlendMode: BlendMode.modulate,
                width: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w185/${movie.posterPath}',
                ),
              ),
            ),
          )
        : SizedBox(
            height: 0,
            width: 0,
          );
  }
}
