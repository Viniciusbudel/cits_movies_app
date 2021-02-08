import 'package:cits_movie_app/data/models/remote_movies_model.dart';
import 'package:cits_movie_app/presentation/presenters/movies_presenter.dart';
import 'package:cits_movie_app/presentation/presenters/presenters.dart';
import 'package:cits_movie_app/ui/pages/movie_detail/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';


class ItemCard extends StatelessWidget {
  final RemoteMoviesModel moviesModel;
  ItemCard(this.moviesModel);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<GetxMoviesPresenter>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          onTap: () => presenter.goToMovieDetails(moviesModel.id.toString()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w185/${moviesModel.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8,bottom: 2,left: 4),
                child: Text(
                  // products is out demo list
                  moviesModel.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4,bottom: 8,left: 4),
                child: Text(
                  moviesModel.releaseDate,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
