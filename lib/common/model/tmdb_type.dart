import 'package:flutter/material.dart';
import 'package:movie_search/common/ui/icons.dart';

enum TMDB_API_TYPE { MOVIE, TV_SHOW, PERSON, UNKNOWN }

TMDB_API_TYPE tmdbFromString(String? type) {
  switch (type) {
    case 'movie':
      return TMDB_API_TYPE.MOVIE;
    case 'tv':
      return TMDB_API_TYPE.TV_SHOW;
    case 'person':
      return TMDB_API_TYPE.PERSON;
    default:
      return TMDB_API_TYPE.MOVIE;
  }
}

extension tmdb_type on TMDB_API_TYPE {
  String get type {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return 'movie';
      case TMDB_API_TYPE.TV_SHOW:
        return 'tv';
      case TMDB_API_TYPE.PERSON:
        return 'person';
      default:
        return 'unknown';
    }
  }

  String get name {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return 'Películas';
      case TMDB_API_TYPE.TV_SHOW:
        return 'Series';
      case TMDB_API_TYPE.PERSON:
        return 'Celebridades';
      default:
        return 'unknown';
    }
  }

  IconData get icon {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return MyIcons.movie;
      case TMDB_API_TYPE.TV_SHOW:
        return MyIcons.tv;
      case TMDB_API_TYPE.PERSON:
        return MyIcons.castMale;
      default:
        return Icons.adb;
    }
  }

  String get nameSingular {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return 'Película';
      case TMDB_API_TYPE.TV_SHOW:
        return 'Serie';
      case TMDB_API_TYPE.PERSON:
        return 'Persona';
      default:
        return 'unknown';
    }
  }
}
