import 'package:cits_movie_app/data/models/models.dart';
import 'package:cits_movie_app/domain/entities/entities.dart';
import 'package:cits_movie_app/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetxMoviesPresenter {
  final LoadMovies loadMovies;
  final _isLoading = true.obs;
  final _movies = Rx<List<RemoteMoviesModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;

  Stream<List<RemoteMoviesModel>> get moviesStream => _movies.stream;

  GetxMoviesPresenter({@required this.loadMovies});

  Future<void> loadData() async {
    _isLoading.value = true;
    final movies = await loadMovies.load();
    _movies.value = movies
        .map((movie) => RemoteMoviesModel(
            id: movie.id,
            overview: movie.overview,
            voteAverage: movie.voteAverage,
            posterPath: movie.posterPath,
            releaseDate: DateFormat('dd MMM yyyy').format(movie.releaseDate),
            title: movie.title))
        .toList();
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
            releaseDate: DateTime(2020, 10, 03),
            title: faker.randomGenerator.string(244)),
      ];

  mockLoadMovies(List<MoviesEntity> data) {
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

    await sut.loadData();
  });
}
