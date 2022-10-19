class AppLink {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String apiKey = '?api_key=419fff488d94b0e1aec87617f2bd6fe3';

  static const String getNowPlayingUrl = '$baseUrl/movie/now_playing$apiKey';

  static const String getMovieDetailsUrl = '$baseUrl/movie/';

  static const String getPopularUrl = '$baseUrl/movie/popular$apiKey';

  static const String getTopRatedUrl = '$baseUrl/movie/top_rated$apiKey';

  // image
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500/';
}
