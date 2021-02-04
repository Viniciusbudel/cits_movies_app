import 'dart:io';

import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:cits_movie_app/domain/entities/entities.dart';

import 'package:cits_movie_app/data/http/http.dart';
import 'package:cits_movie_app/data/models/models.dart';

class RemoteLoadMovies {
  final String url;
  final HttpClient<List<Map>> httpClient;

  RemoteLoadMovies({
    @required this.url,
    @required this.httpClient,
  });

  Future<List<MoviesEntity>> load() async {
    final httpResponse = await httpClient.request(url: url, method: 'get');

    return httpResponse
        .map((json) => RemoteMoviesModel.fromJson(json).toEntity())
        .toList();
  }
}

class HttpClientSpy extends Mock implements HttpClient<List<Map>> {}

void main() {
  String url;
  HttpClientSpy httpClient;
  RemoteLoadMovies sut;
  List<Map> list;

  List<Map> mockValidData() => [
        {
          'id': faker.randomGenerator.integer(100000000),
          'overview': faker.randomGenerator.string(2000),
          'popularity': faker.randomGenerator.decimal(),
          'posterPath': faker.randomGenerator.string(244),
          'releaseDate': faker.date.dateTime().toIso8601String(),
          'title': faker.randomGenerator.string(244)
        },
        {
          'id': faker.randomGenerator.integer(100000000),
          'overview': faker.randomGenerator.string(2000),
          'popularity': faker.randomGenerator.decimal(),
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
    print(movies.toString());

    expect(movies, [
      MoviesEntity(
        id: list[0]['id'],
        title: list[0]['title'],
        overview: list[0]['overview'],
        popularity: list[0]['popularity'],
        posterPath: list[0]['posterPath'],
        releaseDate: DateTime.parse(list[0]['releaseDate']),
      ),
      MoviesEntity(
        id: list[1]['id'],
        title: list[1]['title'],
        overview: list[1]['overview'],
        popularity: list[1]['popularity'],
        posterPath: list[1]['posterPath'],
        releaseDate: DateTime.parse(list[1]['releaseDate']),
      ),
    ]);
  });
}
