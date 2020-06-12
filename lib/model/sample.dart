class Sample {
  String title;
  String description;
  String clone;
  bool isPWA;
  String image;
  String url;
  String demo;
  List<String> screenshots;


  Sample({this.title, this.description, this.clone, this.isPWA, this.image, this.url, this.demo, this.screenshots});

  factory Sample.toObject(Map<String, dynamic> json) => Sample(
      title: json['title'],
      description: json['description'],
      clone: json['clone'],
      isPWA: json['isPWA'],
      image: json['image'],
      url: json['url'],
      demo: json['demo'],
      screenshots: json['screenshots']
  );

  Map<String, dynamic> toMap() => {
    'title': this.title,
    'description': this.description,
    'clone': this.clone,
    'isPWA': this.isPWA,
    'image': this.image,
    'url': this.url,
    'demo': this.demo,
    'screenshots': this.screenshots
  };
}