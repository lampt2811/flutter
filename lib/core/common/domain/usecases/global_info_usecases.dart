// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vinemas/core/common/domain/repositories/global_repository.dart';
import 'package:vinemas/features/home/domain/entities/genre.dart';
import 'package:vinemas/features/home/domain/entities/image_configuration.dart';
import 'package:vinemas/features/home/domain/repositories/movie_repository.dart';

class GlobalInfoUsecases {
  final MovieRepository repository;
  final GlobalRepository globalRepository;
  GlobalInfoUsecases({
    required this.repository,
    required this.globalRepository,
  });

  Future<List<Genre>?> getGenre() {
    return repository.getGenre();
  }

  Future<ImageConfigInfo?> getImageInfo() {
    return repository.getImageInfo();
  }

  Future<Locale?> getLocale() {
    return globalRepository.getLocale();
  }

  Future<bool> setSavedLangCode(String langCode) {
    return globalRepository.setSavedLangCode(langCode);
  }
}