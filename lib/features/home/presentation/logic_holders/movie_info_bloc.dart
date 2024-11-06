// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinemas/features/home/domain/entities/movie.dart';
import 'package:vinemas/features/home/domain/usecases/movie_usecase.dart';

part 'movie_info_event.dart';
part 'movie_info_state.dart';

class MovieInfoBloc extends Bloc<MoviesEvent, MoviesState> {
  GetMovies getMovies;
  MovieInfoBloc(
    this.getMovies,
  ) : super(MoviesInitial()) {
    on<LoadMovies>(_onLoadMovies);
  }

  Future<void> _onLoadMovies(
      LoadMovies event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    try {
      final nowPlayingMovies = await getMovies.getNowPlayingMovies();
      final upCommingMovies = await getMovies.getUpcommingMovie();
      emit(MoviesLoaded(
        nowPlayingMovies ?? [],
        upCommingMovies ?? [],
      ));
    } catch (error) {
      emit(MoviesError(error.toString()));
    }
  }
}