import 'package:flutter_movie/data/models/genre.dart';

String millisToHourAndMin(int? millis) {
  if (millis == null) {
    return "Unkown";
  }

  int seconds = (millis / 1000).truncate();
  int minutes = (seconds / 60).truncate();
  int hours = (minutes / 60).truncate();

  return "${hours}hr ${minutes}m";
}

List<String> getGenreNames(List<int>? genreIds, List<Genre> genres) {
  List<String> genreNames = [];

  if (genreIds == null) {
    return genreNames;
  }

  for (int id in genreIds) {
    genres.firstWhere((e) {
      if (e.id == id) {
        genreNames.add(e.name);
        return true;
      } else {
        return false;
      }
    });
  }

  return genreNames;
}

String durationToMinSec(Duration duration) {
  int min = duration.inMinutes;
  int sec = duration.inSeconds % 60;
  return '$min:$sec';
}
