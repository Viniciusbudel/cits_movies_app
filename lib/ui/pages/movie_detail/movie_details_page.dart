import 'package:cits_movie_app/data/models/remote_movie_detail_model.dart';
import 'package:cits_movie_app/domain/usecases/load_movie_details.dart';
import 'package:cits_movie_app/presentation/presenters/getx_movie_detail_presenter.dart';
import 'package:cits_movie_app/ui/pages/movie_detail/components/circular_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                      Container(
                        child: Hero(
                          tag:
                              'https://image.tmdb.org/t/p/w185/okhrkHYF94K4kLXLwZkQMhWZ0fL.jpg',
                          child: ClipShadowPath(
                            clipper: CircularClipper(),
                            shadow: Shadow(
                                blurRadius: 10,
                                color: Theme.of(context).primaryColor),
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
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: Column(
                          children: [
                            Text(
                              movie.title,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  movie.releaseDate,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                VerticalDivider(),
                                Text(
                                  '${movie.runtime.toString()} minutos',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                VerticalDivider(
                                  color: Colors.white,
                                ),
                                Text(
                                  'Nota: ${movie.voteAverage}',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Gêneros : ',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  _txtGenres(movie),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Resumo',
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data.overview,
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.center,
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
    movie.genres.forEach((element) {
      generos += '${element.name}, ';
    });
    return generos.substring(0, generos.length - 2);
  }
}
