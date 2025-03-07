import '../../data/models/models.dart';

import '../../domain/usecases/usecases.dart';

abstract class MoviesDetailPresenter {
  Stream<bool> get isLoadingStream;

  Stream<RemoteMovieDetailModel> get movieDetailStream;

  Future<void> loadData(LoadMovieDetailParams params);
}
