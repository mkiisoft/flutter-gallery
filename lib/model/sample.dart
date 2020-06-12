class Sample {
  String title;
  String description;
  String path;
  String clone;
  bool isPWA;
  String image;
  String url;
  String demo;
  List<String> screenshots;

  Sample(
      {this.title,
      this.description,
      this.path,
      this.clone,
      this.isPWA,
      this.image,
      this.url,
      this.demo,
      this.screenshots});

  factory Sample.toObject(Map<String, dynamic> json) => Sample(
      title: json['title'],
      description: json['description'],
      path: json['path'],
      clone: json['clone'],
      isPWA: json['isPWA'],
      image: json['image'],
      url: json['url'],
      demo: json['demo'],
      screenshots: (json['screenshots'] as List).cast<String>());

  Map<String, dynamic> toMap() => {
        'title': this.title,
        'description': this.description,
        'path': this.path,
        'clone': this.clone,
        'isPWA': this.isPWA,
        'image': this.image,
        'url': this.url,
        'demo': this.demo,
        'screenshots': this.screenshots
      };

  @override
  String toString() {
    return 'Sample{title: $title, description: $description, path: $path, clone: $clone, isPWA: $isPWA, image: $image, url: $url, demo: $demo, screenshots: $screenshots}';
  }


}
