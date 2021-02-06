import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';

class ItemCard extends StatelessWidget {
  // final RemoteMoviesModel moviesModel;
  // final Function press;
  //
  // const ItemCard({
  //   Key key,
  //   this.moviesModel,
  //   this.press,
  // }) : super(key: key);

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
          //onTap: press,
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
                  'Father',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                child: Text(
                  '03/03/2020',
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
