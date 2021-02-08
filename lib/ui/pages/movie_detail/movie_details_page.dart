import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/load_movie_details.dart';

import '../../../data/models/remote_movie_detail_model.dart';

import '../../../presentation/presenters/presenters.dart';

import '../../../ui/components/components.dart';

import '../../pages/movie_detail/components/components.dart';

class MovieDetailPage extends StatelessWidget {
  final GetxMovieDetailsPresenter presenter;

  MovieDetailPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes Detalhes'),
      ),
      body: Builder(
        builder: (context) {
          presenter.loadData(LoadMovieDetailParams(
              apiKey: '7c130c4d6b5a83e1a0223a8cbf26b27a'));

          return StreamBuilder<RemoteMovieDetailModel>(
              stream: presenter.movieDetailStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text(snapshot.error),
                      RaisedButton(
                        onPressed: null,
                        child: Text('Recarregar'),
                      )
                    ],
                  );
                }
                if (snapshot.hasData) {
                  final movie = snapshot.data;
                  return ListView(
                    children: [
                      ImgMovieDetails(movie: movie),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: Column(
                          children: [
                            Headline1(value: movie.title),
                            SizedBox(height: 5),
                            RowMovieDetails(movie: movie),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Gêneros : ',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle2,
                                ),
                                Expanded(
                                  child: Text(
                                    _txtGenres(movie),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Headline1(value: "Resumo"),
                            SizedBox(height: 5),
                            Subtitle1(
                              value: movie.overview,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return SizedBox(height: 0);
              });
        },
      ),
    );
  }

  String _txtGenres(RemoteMovieDetailModel movie) {
    String generos = "";
    if (movie.genres.isNotEmpty) {
      movie.genres.forEach((element) {
        generos += '${element.name}, ';
      });
      return generos.substring(0, generos.length - 2);
    } else {
      return ' - ';
    }
  }
}

