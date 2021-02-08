import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:cits_movie_app/domain/entities/entities.dart';
import 'package:cits_movie_app/domain/helpers/helpers.dart';
import 'package:cits_movie_app/domain/usecases/usecases.dart';

import 'package:cits_movie_app/data/models/models.dart';

import 'package:cits_movie_app/presentation/presenters/getx_movies_presenter.dart';

import 'package:cits_movie_app/ui/helpers/errors/ui_error.dart';

class LoadMoviesSpy extends Mock implements LoadMovies {}

void main() {
  LoadMoviesSpy loadMovies;
  GetxMoviesPresenter sut;
  List<MoviesEntity> movies;
  LoadMoviesParams params;



  mockValidData() => [
        MoviesEntity(
            id: faker.randomGenerator.integer(100000),
            overview: faker.randomGenerator.string(2000),
            voteAverage: faker.randomGenerator.decimal(),
            posterPath: faker.randomGenerator.string(244),
            releaseDate: DateTime(2020, 2, 20),
            title: faker.randomGenerator.string(244)),
        MoviesEntity(
            id: faker.randomGenerator.integer(100000),
            overview: faker.randomGenerator.string(2000),
            voteAverage: faker.randomGenerator.decimal(),
            posterPath: faker.randomGenerator.string(244),
            releaseDate: DateTime(2020, 10, 03),
            title: faker.randomGenerator.string(244)),
      ];

  PostExpectation mockLoadMoviesCall() => when(loadMovies.load(params: params));

  void mockLoadMoviesError() =>
      mockLoadMoviesCall().thenThrow(DomainError.unexpected);

  mockLoadMovies(List<MoviesEntity> data) {
    movies = data;
    when(loadMovies.load(params: params)).thenAnswer((_) async => movies);
  }

  setUp(() {

    params = LoadMoviesParams(apiKey: '7c130c4d6b5a83e1a0223a8cbf26b27a');
    loadMovies = LoadMoviesSpy();
    sut = GetxMoviesPresenter(loadMovies: loadMovies);
    mockLoadMovies(mockValidData());
  });

  test('Should call LoadMovies on loadData', () async {
    await sut.loadData(params);

    verify(loadMovies.load(params: params)).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.moviesStream.listen(expectAsync1((movies) => expect(movies, [
          RemoteMoviesModel(
              id: movies[0].id,
              overview: movies[0].overview,
              voteAverage: movies[0].voteAverage,
              posterPath: movies[0].posterPath,
              releaseDate: '20 Fev 2020',
              title: movies[0].title),
          RemoteMoviesModel(
              id: movies[1].id,
              overview: movies[1].overview,
              voteAverage: movies[1].voteAverage,
              posterPath: movies[1].posterPath,
              releaseDate: '03 Out 2020',
              title: movies[0].title),
        ])));

    await sut.loadData(params);
  });

  test('Should emit correct events on failure', () async {
    mockLoadMoviesError();
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.moviesStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));

    await sut.loadData(params);
  });
}
