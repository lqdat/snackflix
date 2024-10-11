class Movies {
  String name;
  String slug;
  String origin_name;
  String poster_url;

  Movies({
    required this.name,
    required this.slug,
    required this.origin_name,
    required this.poster_url,
  });

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      name: json["name"],
      slug: json["slug"],
      origin_name: json["origin_name"],
      poster_url: json["poster_url"],
    );
  }
}
