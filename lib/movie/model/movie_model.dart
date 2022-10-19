class MovieModel {
  List<Results>? results;

  MovieModel({this.results});

  MovieModel.fromJson(Map<String, dynamic> json) {
    results = <Results>[];
    json['results'].forEach((v) {
      results!.add(Results.fromJson(v));
    });
  }
}

class Results {
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalTitle;
  String? overview;
  String? releaseDate;
  String? title;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  Results(
      {this.backdropPath,
      this.genreIds,
      this.id,
      this.originalTitle,
      this.overview,
      this.releaseDate,
      this.title,
      this.voteAverage,
      this.voteCount,
      this.posterPath});

  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];
    posterPath = json['poster_path'] ?? '/rgZ3hdzgMgYgzvBfwNEVW01bpK1.jpg';
  }
}
