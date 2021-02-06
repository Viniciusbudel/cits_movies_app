import 'package:cits_movie_app/data/models/models.dart';
import 'package:cits_movie_app/presentation/presenters/movies_presenter.dart';
import 'package:cits_movie_app/ui/pages/upcoming_movies/components/item_card.dart';
import 'package:flutter/material.dart';

class UpcomingMoviesPage extends StatelessWidget {
  final MoviesPresenter presenter;

  UpcomingMoviesPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Próximas Estréias'),
      ),
      body: StreamBuilder<List<RemoteMoviesModel>>(
          //stream: presenter.loadData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(snapshot.error),
                  RaisedButton(onPressed: null, child: Text('Recarregar'),)
                ],
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) => ItemCard(),
              itemCount: 15,
            );
          }
      ),
    );
  }
}
