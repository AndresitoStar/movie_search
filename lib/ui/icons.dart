import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/providers/util.dart';

class MyIcons {
  static const IconData home = FrinoIcons.f_home_simple;
  static const IconData settings = FrinoIcons.f_settings;
  static const IconData categories = FrinoIcons.f_dashboard;

  static const IconData arrow_left = FrinoIcons.f_arrow_left;
  static const IconData arrow_right = FrinoIcons.f_arrow_right;
  static const IconData check = FrinoIcons.f_check;
  static const IconData clean = FrinoIcons.f_no_access;
  static const IconData favourite_on = Icons.favorite_rounded;
  static const IconData favourite_off = FrinoIcons.f_heart;
  static const IconData clear = Icons.clear;
  static const IconData search = FrinoIcons.f_search_2;
  static const IconData more = FrinoIcons.f_more_horizontal;
  static const IconData default_image = Icons.photo;
  static const IconData imdb = FontAwesomeIcons.imdb;
  static const IconData quality = Icons.high_quality_rounded;
  static const IconData history = FrinoIcons.f_clock;
  static const IconData people = Icons.group_outlined;
  static const IconData castMale = FrinoIcons.f_male;
  static const IconData castFemale = FrinoIcons.f_female;
  static const IconData star = FrinoIcons.f_star_filled;

  static const IconData movie = FrinoIcons.f_movie_tape;
  static const IconData tv = FrinoIcons.f_tv;
  static const IconData filter = FrinoIcons.f_filter;
  static const IconData calendar = FrinoIcons.f_calendar;

  static const IconData download = FrinoIcons.f_download;

  static const IconData error = Icons.warning;

  static IconData iconFromType(TMDB_API_TYPE type) {
    if (type == TMDB_API_TYPE.MOVIE) return movie;
    if (type == TMDB_API_TYPE.TV_SHOW) return tv;
    if (type == TMDB_API_TYPE.PERSON) return castMale;
    return null;
  }
}
