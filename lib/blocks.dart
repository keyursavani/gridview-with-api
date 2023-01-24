class Blocks{
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Blocks({required this.albumId , required this.id ,
    required this.title , required this.url ,
    required this.thumbnailUrl
  });

  static Blocks fromJson(json) => Blocks(
    albumId: json['albumId'],
    id: json['id'],
    title: json['title'],
    url: json['url'],
    thumbnailUrl: json['thumbnailUrl'],
  );

}