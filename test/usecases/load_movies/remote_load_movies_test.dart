import 'dart:io';

import 'package:cits_movie_app/data/usecases/load_movies/remote_load_movies.dart';
import 'package:cits_movie_app/domain/helpers/helpers.dart';
import 'package:cits_movie_app/domain/usecases/load_movies.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:cits_movie_app/domain/entities/entities.dart';
import 'package:cits_movie_app/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  String url;
  HttpClientSpy httpClient;
  RemoteLoadMovies sut;
  var list;
  LoadMoviesParams params;

  mockValidData() => {
        "results": [
          {
            'id': faker.randomGenerator.integer(100000000),
            'overview': faker.randomGenerator.string(2000),
            'vote_average': faker.randomGenerator.decimal(),
            'poster_path': faker.randomGenerator.string(244),
            'release_date': faker.date.dateTime().toIso8601String(),
            'title': faker.randomGenerator.string(244)
          },
          {
            'id': faker.randomGenerator.integer(100000000),
            'overview': faker.randomGenerator.string(2000),
            'vote_average': faker.randomGenerator.decimal(),
            'poster_path': faker.randomGenerator.string(244),
            'release_date': faker.date.dateTime().toIso8601String(),
            'title': faker.randomGenerator.string(244)
          }
        ]
      };

  PostExpectation mockRequest() => when(
      httpClient.request(url: anyNamed('url'), method: anyNamed('method')));

  void mockHttpData(data) {
    list = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    params = LoadMoviesParams(apiKey: '7c130c4d6b5a83e1a0223a8cbf26b27a');
    sut = RemoteLoadMovies(url: url, httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test('Should return Movies on 200', () async {
    final movies = await sut.load(params: params);

    expect(movies, [
      MoviesEntity(
        id: list['results'][0]['id'],
        title: list['results'][0]['title'],
        overview: list['results'][0]['overview'],
        voteAverage: list['results'][0]['vote_average'],
        posterPath: list['results'][0]['poster_path'],
        releaseDate: DateTime.parse(list['results'][0]['release_date']),
      ),
      MoviesEntity(
        id: list['results'][1]['id'],
        title: list['results'][1]['title'],
        overview: list['results'][1]['overview'],
        voteAverage: list['results'][1]['vote_average'],
        posterPath: list['results'][1]['poster_path'],
        releaseDate: DateTime.parse(list['results'][1]['release_date']),
      ),
    ]);
  });

  test('Should throw UnexpectedError if HttpClient return 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.load(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.load(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.load(params: params);

    expect(future, throwsA(DomainError.accessDenied));
  });
}
