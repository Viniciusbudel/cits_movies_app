import 'package:cits_movie_app/ui/pages/upcoming_movies/components/item_card.dart';
import 'package:flutter/material.dart';

class UpcomingMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Próximas Estréias'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) => ItemCard(),
        itemCount: 15,
      ),
    );
  }
}
