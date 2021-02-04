import 'dart:io';

import 'package:cits_movie_app/data/http/http.dart';
import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteLoadMovies {
  final String url;
  final HttpClient httpClient;

  RemoteLoadMovies({
    @required this.url,
    @required this.httpClient,
  });

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient with correct values', () async {
    final url = faker.internet.httpUrl();
    final httpClient = HttpClientSpy();
    final sut = RemoteLoadMovies(url: url, httpClient: httpClient);

    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });
}
