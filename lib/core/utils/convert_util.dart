import 'package:vinemas/features/home/domain/entities/genre.dart';

List<Genre> convertGenreIdsToGenreStrings(
    List<int> listGenreIds, List<Genre> listGenres) {
  return listGenreIds
      .map((eId) => listGenres.firstWhere((value) => eId == value.id))
      .toList();
}