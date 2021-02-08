import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/load_movies.dart';

import '../../../data/models/models.dart';

import '../../../presentation/presenters/presenters.dart';

import '../../../ui/pages/upcoming_movies/components/item_card.dart';

class UpcomingMoviesPage extends StatefulWidget {
  final GetxMoviesPresenter presenter;

  UpcomingMoviesPage(this.presenter);

  @override
  _UpcomingMoviesPageState createState() => _UpcomingMoviesPageState();
}

class _UpcomingMoviesPageState extends State<UpcomingMoviesPage> {
  int page = 1;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Próximas Estréias'),
      ),
      body: Builder(builder: (context) {
        widget.presenter.loadData(LoadMoviesParams(
            apiKey: '7c130c4d6b5a83e1a0223a8cbf26b27a', page: page.toString()));
        return StreamBuilder<List<RemoteMoviesModel>>(
            stream: widget.presenter.moviesStream,
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (context, index) =>
                      ItemCard(snapshot.data[index]),
                  itemCount: snapshot.data.length,
                );
              }
              return SizedBox(height: 0);
            });
      }),
      bottomSheet: Container(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton.icon(
                color: Theme.of(context).primaryColorDark,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColorLight,
                ),
                label: Text(
                  'Voltar',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                onPressed: () => _onClickBack(),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: RaisedButton.icon(
                  color: Theme.of(context).primaryColorDark,
                  label: Text(
                    'Avançar',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () => _onClickForward(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClickBack() {
    if (page != 1){
      page --;
      widget.presenter.loadData(LoadMoviesParams(
          apiKey: '7c130c4d6b5a83e1a0223a8cbf26b27a', page: page.toString()));
    }
  }

  void _onClickForward() {
    page ++;
    widget.presenter.loadData(LoadMoviesParams(
        apiKey: '7c130c4d6b5a83e1a0223a8cbf26b27a', page: page.toString()));
  }
}
