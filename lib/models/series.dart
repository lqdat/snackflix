class Series {
  String backdropPath;
  String firstAirDate;
  List<int> genreIds;
  int id;
  String name;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  double voteAverage;
  int voteCount;

  Series({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      backdropPath: json["backdrop_path"] ?? "",
      firstAirDate: json["first_air_date"] ?? "",
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      name: json["name"] ?? "",
      originCountry: List<String>.from(json["origin_country"].map((x) => x)),
      originalLanguage: json["original_language"] ?? "",
      originalName: json["original_name"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"] ?? "",
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
    );
  }
}
