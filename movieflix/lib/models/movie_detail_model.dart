class MovieDetailModel {
  final String title, overview, backdropPath, posterPath, tagline;
  final bool adult;
  final List<dynamic> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        backdropPath = json['backdrop_path'],
        posterPath = json['poster_path'],
        adult = json['adult'],
        tagline = json['tagline'],
        genres = json['genres'];
}
