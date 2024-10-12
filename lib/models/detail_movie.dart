class ServerData {
  String link_embed;
  String link_m3u8;
  String name;
  String filename;
  ServerData({required this.filename,required this.name, required this.link_embed, required this.link_m3u8});
  factory ServerData.fromJson(Map<String, dynamic> json) {
    ServerData res = ServerData(
        link_embed: json['link_embed'],
         link_m3u8: json['link_m3u8'],
         filename:  json['filename'],
         name:json['name']
         );
    return res;
  }
}

class DetailMovie {
  String name;
  String slug;
  String origin_name;
  String content;
  String type;
  String poster_url;
  String thumb_url;
  bool chieurap;
  String status;
  String time;
  String episode_current;
  String episode_total;
  String quality;
  String lang;
  int year;

  DetailMovie({
    required this.name,
    required this.slug,
    required this.origin_name,
    required this.content,
    required this.type,
    required this.poster_url,
    required this.thumb_url,
    required this.chieurap,
    required this.status,
    required this.time,
    required this.episode_current,
    required this.episode_total,
    required this.quality,
    required this.lang,
    required this.year,
  });

  factory DetailMovie.fromJson(Map<String, dynamic> json) {
    DetailMovie res = DetailMovie(
      name: json["name"],
      slug: json["slug"],
      origin_name: json["origin_name"],
      content: json["content"],
      type: json["type"],
      poster_url: json["poster_url"],
      thumb_url: json["thumb_url"],
      chieurap: json["chieurap"].toString().toLowerCase() == 'true',
      status: json["status"],
      time: json["time"],
      episode_current: json["episode_current"],
      episode_total: json["episode_total"],
      quality: json["quality"],
      lang: json["lang"],
      year: json["year"],
    );
    return res;
  }
}
