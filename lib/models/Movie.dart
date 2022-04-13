class Movie{
  late final String _title;
  late final String _imageUrl;
  late final String _description;
  late final String _year;


  Movie(Map<String, dynamic> json){
    _title = json['title'] ?? json['name'];
    _imageUrl = "https://image.tmdb.org/t/p/original/"+json['poster_path'];
    _description = json['overview'];
    _year = json['release_date'];
  }

  String get title => _title;
  String get imageUrl => _imageUrl;
  String get description => _description;
  String get year => _year;

  Movie.fromJson(Map<String, dynamic> json)
    : _title = json['title'],
      _imageUrl = json['poster_path'],
      _description = json['overview'],
      _year = json['release_date'];


  Map<String, dynamic> toJson() => {
    'title': _title,
    'imageUrl': _imageUrl,
    'description': _description,
    'year': _year
  };

  @override
  String toString() {
    return 'Movie{_title: $_title, _imageUrl: $_imageUrl, _description: $_description, _year: $_year}';
  }
}
