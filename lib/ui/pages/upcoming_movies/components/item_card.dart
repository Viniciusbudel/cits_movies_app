import 'package:cits_movie_app/data/models/remote_movies_model.dart';
import 'package:cits_movie_app/ui/pages/movie_detail/movie_details_page.dart';
import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';


class ItemCard extends StatelessWidget {
  final RemoteMoviesModel moviesModel;
  ItemCard(this.moviesModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          onTap: () => push(context, MovieDetailPage()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w185/okhrkHYF94K4kLXLwZkQMhWZ0fL.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Text(
                  // products is out demo list
                  moviesModel.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                child: Text(
                  moviesModel.releaseDate,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
