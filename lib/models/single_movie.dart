class SingleMovie {
  String name;
  String slug;
  String poster_url;

  SingleMovie({
    required this.name,
    required this.slug,
    required this.poster_url,
  });

  factory SingleMovie.fromJson(Map<String, dynamic> json) {
    return SingleMovie(
      name: json["name"],
      slug: json["slug"],
      poster_url: json["poster_url"],
    );
  }
}
