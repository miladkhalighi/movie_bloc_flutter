class MovieApiConstants {
  MovieApiConstants._();

  static const String apiKey = "19a58c2a64b56b3a88c89f00dddedad2"; //v3 auth
  static const String apiToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxOWE1OGMyYTY0YjU2YjNhODhjODlmMDBkZGRlZGFkMiIsInN1YiI6IjYzZjFmMzdiNGE0YmZjMDA5NjM4NDFhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ig4bdvf-2vFSf2hH5DJ4W0hSM1s8xcWj5ahqB1Lqxiw"; //v4 auth

  static const String baseUrl = "https://api.themoviedb.org";
  static const String getMoviesListPath = '/3/search/movie';
  static const String getMoviePath = '/3/find/';
  static const String getMovieTrendingPath = '/3/trending/all/week';
  static const String nowPlayingPath = '/3/movie/now_playing';

  static const String mostPopularPath = '/3/movie/popular';
  static const String topRatedPath = '/3/movie/top_rated';
  static const String nowUpComingPath = '/3/movie/upcoming';
}
