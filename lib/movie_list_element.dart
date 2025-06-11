class MovieListElement{
// poster_path,title,overview,popularity,vote_average
//original_language
//id
  final String posterPath;
  final String title;
  final double popularity;
  final String voteAverage;
  final String originalLanguage;
  final String overview;
  final int id;
  final String releaseDate;

  MovieListElement({
    required this.posterPath,
    required this.title,
    required this.popularity,
    required this.voteAverage,
    required this.originalLanguage,
    required this.overview,
    required this.id,
    required this.releaseDate,
  });


}