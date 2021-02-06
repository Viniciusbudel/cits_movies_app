import 'package:cits_movie_app/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class GetxMoviesPresenter {
  final LoadMovies loadMovies;

  GetxMoviesPresenter({@required this.loadMovies});

  Future<void> loadData() async {
    await loadMovies.load();
  }
}

class LoadMoviesSpy extends Mock implements LoadMovies {}

void main() {
  test('Should call LoadMovies on loadData', () async {
    final loadMovies = LoadMoviesSpy();
    final sut = GetxMoviesPresenter(loadMovies: loadMovies);

    await sut.loadData();

    verify(loadMovies.load()).called(1);
  });
}
