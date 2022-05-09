extension MovieImage on String {
  String toImageUrl({String size = "w200"}) {
    return "http://image.tmdb.org/t/p/$size/$this";
  }
}
