import 'package:cits_movie_app/domain/entities/entities.dart';
import 'package:cits_movie_app/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

class GetxMoviesPresenter {
  final LoadMovies loadMovies;
  final _isLoading = true.obs;

  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxMoviesPresenter({@required this.loadMovies});

  Future<void> loadData() async {
    _isLoading.value = true;
    await loadMovies.load();
    _isLoading.value = false;

  }
}

class LoadMoviesSpy extends Mock implements LoadMovies {}

void main() {
  LoadMoviesSpy loadMovies;
  GetxMoviesPresenter sut;
  List<MoviesEntity> movies;

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
            releaseDate: DateTime(2020, 2, 20),
            title: faker.randomGenerator.string(244)),
      ];

  mockLoadMovies(List<MoviesEntity> data){
    movies = data;
    when(loadMovies.load()).thenAnswer((_) async => movies);
  }

  setUp(() {
    loadMovies = LoadMoviesSpy();
    sut = GetxMoviesPresenter(loadMovies: loadMovies);
    mockLoadMovies(mockValidData());
  });

  test('Should call LoadMovies on loadData', () async {
    await sut.loadData();

    verify(loadMovies.load()).called(1);
  });

  test('Should call LoadMovies on loadData', () async {
    await sut.loadData();
  });

  test('Should emit correct events on sucess', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true,false]));
    
    await sut.loadData();
  });


}
