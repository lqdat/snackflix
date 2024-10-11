class SingleMovie {
  String name;
  String slug;
  String poster_url;
  String type;

  SingleMovie({
    required this.name,
    required this.slug,
    required this.poster_url,
    required this.type
  });

  factory SingleMovie.fromJson(Map<String, dynamic> json) {
    return SingleMovie(
      name: json["name"],
      slug: json["slug"],
      poster_url: json["poster_url"],
      type:  json["type"]
    );
  }
}
