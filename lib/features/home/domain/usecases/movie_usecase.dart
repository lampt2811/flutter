import 'package:vinemas/features/home/domain/entities/movie.dart';
import 'package:vinemas/features/home/domain/repositories/movie_repository.dart';

//!  use case để xử lý nghiệp vụ, ở đây có nghiệp vụ lấy danh sách phim
class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>?> getNowPlayingMovies() async {
    return await repository.getMovies();
  }

  Future<List<Movie>?> getUpcommingMovie() {
    return repository.getUpcommingMovies();
  }
}