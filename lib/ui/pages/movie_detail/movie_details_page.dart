import 'package:cits_movie_app/ui/pages/movie_detail/components/circular_clipper.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes Detalhes'),
      ),
      body: ListView(
        children: [
          Container(
            child: Hero(
              tag:
                  'https://image.tmdb.org/t/p/w185/okhrkHYF94K4kLXLwZkQMhWZ0fL.jpg',
              child: ClipShadowPath(
                clipper: CircularClipper(),
                shadow: Shadow(
                    blurRadius: 10, color: Theme.of(context).primaryColor),
                child: Image(
                  height: 300,
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  colorBlendMode: BlendMode.modulate,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(

                    'https://image.tmdb.org/t/p/w185/okhrkHYF94K4kLXLwZkQMhWZ0fL.jpg',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Column(
              children: [
                Text(
                  'Father',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '03/03/2020',
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Um homem idoso recusa toda a ajuda de sua filha à medida que envelhece. Ela está se mudando para Paris e precisa garantir os cuidados dele enquanto estiver fora, buscando encontrar alguém para cuidar do pai. Ao tentar entender suas mudanças, ele começa a duvidar de seus entes queridos, de sua própria mente e até mesmo da estrutura da realidade.',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
