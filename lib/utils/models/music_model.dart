/// Music Model

class MusicModel {

  /// Parameters
  final String title;
  final String subtitle;
  final String backgroundImage;
  final String image;
  final String audioUri;
  final String spotifyUri;
  final String deezerUri;
  final String shazamUri;
  final String genres;
  final String album;
  final String label;
  final String release;
  final List<String> lyrics;
  final String lyricsAuthor;


  /// Constructor
  MusicModel({
    required this.title,
    required this.subtitle,
    required this.backgroundImage,
    required this.image,
    required this.audioUri,
    required this.spotifyUri,
    required this.deezerUri,
    required this.shazamUri,
    required this.genres,
    required this.album,
    required this.label,
    required this.release,
    required this.lyrics,
    required this.lyricsAuthor,});


  /// Factory constructor from json
  factory MusicModel.fromJson(json) {

    /// Sound with lyrics i = 1 for 1 section of lyrics in section array
    int i = 1;
    List<dynamic> lyricsJsonList;

    /// Condition for checking lyrics
    if(json['sections'][1]['type'] == "LYRICS") {

      /// If have lyrics init it
      lyricsJsonList = json['sections'][1]['text'];
    } else {

      /// Else condition array index is -1
      i = 0;

      /// And lyrics is "Without Lyrics" sub comment
      lyricsJsonList = ["Без текста"];
    }

    /// Constructor
    return MusicModel(
        title: json['title'],
        subtitle: json['subtitle'],
        backgroundImage: json['images']['background'],
        image: json['images']['coverart'],
        audioUri: json['hub']['actions'][1]['uri'],
        spotifyUri: json['hub']['providers'][0]['actions'][0]['uri'],
        deezerUri: json['hub']['providers'][1]['actions'][0]['uri'],
        shazamUri: json['url'],
        genres: json['genres']['primary'],
        album: json['sections'][0]['metadata'][0]['text'],
        label: json['sections'][0]['metadata'][1]['text'],
        release: json['sections'][0]['metadata'][2]['text'],
        lyrics: lyricsJsonList.map((e) => e.toString()).toList(),
        lyricsAuthor: json['sections'][1]['footer'] ?? "",
    );
  }
}