import 'dart:io';

import 'package:cits_movie_app/data/usecases/load_movies/remote_load_movies.dart';
import 'package:cits_movie_app/domain/helpers/helpers.dart';
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
  List<Map> list;

  List<Map> mockValidData() => [
        {
          'id': faker.randomGenerator.integer(100000000),
          'overview': faker.randomGenerator.string(2000),
          'vote_average': faker.randomGenerator.decimal(),
          'posterPath': faker.randomGenerator.string(244),
          'releaseDate': faker.date.dateTime().toIso8601String(),
          'title': faker.randomGenerator.string(244)
        },
        {
          'id': faker.randomGenerator.integer(100000000),
          'overview': faker.randomGenerator.string(2000),
          'vote_average': faker.randomGenerator.decimal(),
          'posterPath': faker.randomGenerator.string(244),
          'releaseDate': faker.date.dateTime().toIso8601String(),
          'title': faker.randomGenerator.string(244)
        }
      ];

  PostExpectation mockRequest() => when(
      httpClient.request(url: anyNamed('url'), method: anyNamed('method')));

  void mockHttpData(List<Map> data) {
    list = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadMovies(url: url, httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });

  test('Should return Movies on 200', () async {
    final movies = await sut.load();

    expect(movies, [
      MoviesEntity(
        id: list[0]['id'],
        title: list[0]['title'],
        overview: list[0]['overview'],
        voteAverage: list[0]['vote_average'],
        posterPath: list[0]['posterPath'],
        releaseDate: DateTime.parse(list[0]['releaseDate']),
      ),
      MoviesEntity(
        id: list[1]['id'],
        title: list[1]['title'],
        overview: list[1]['overview'],
        voteAverage: list[1]['vote_average'],
        posterPath: list[1]['posterPath'],
        releaseDate: DateTime.parse(list[1]['releaseDate']),
      ),
    ]);
  });

  test('Should throw UnexpectedError on 200 with invalid_data', () async {
    mockHttpData([
      {'invalid_data': 'invalid_value'}
    ]);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
