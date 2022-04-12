class HomeModel {
  HomeModel({
    required this.slideshow,
    required this.videos,
  });
  late final List<Slideshow> slideshow;
  late final List<Videos> videos;

  HomeModel.fromJson(Map<String, dynamic> json) {
    slideshow =
        List.from(json['slideshow']).map((e) => Slideshow.fromJson(e)).toList();
    videos = List.from(json['videos']).map((e) => Videos.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slideshow'] = slideshow.map((e) => e.toJson()).toList();
    _data['videos'] = videos.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Slideshow {
  Slideshow({
    required this.title,
    required this.url,
    required this.thumbnail,
  });
  late final String title;
  late final String url;
  late final String thumbnail;

  Slideshow.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['url'] = url;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}

class Videos {
  Videos({
    required this.id,
    required this.title,
    required this.published,
    required this.from,
    required this.duration,
    required this.checked,
    required this.liveStatus,
    required this.thumbnail,
    this.live,
  });
  late final String id;
  late final String title;
  late final int published;
  late final From from;
  late final int duration;
  late final int checked;
  late final String liveStatus;
  late final Thumbnail thumbnail;
  late final Live? live;

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    published = json['published'];
    from = From.fromJson(json['from']);
    duration = json['duration'];
    checked = json['checked'];
    liveStatus = json['live_status'];
    thumbnail = Thumbnail.fromJson(json['thumbnail']);
    live = json['live'] == null ? null : Live.fromJson(json['live']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['published'] = published;
    _data['from'] = from.toJson();
    _data['duration'] = duration;
    _data['checked'] = checked;
    _data['live_status'] = liveStatus;
    _data['thumbnail'] = thumbnail.toJson();
    _data['live'] = live!.toJson();
    return _data;
  }
}

class From {
  From({
    required this.name,
    required this.slug,
    required this.channelId,
  });
  late final String name;
  late final String slug;
  late final String channelId;

  From.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    channelId = json['channel_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['slug'] = slug;
    _data['channel_id'] = channelId;
    return _data;
  }
}

class Thumbnail {
  Thumbnail({
    required this.normal,
    required this.mini,
  });
  late final String normal;
  late final String mini;

  Thumbnail.fromJson(Map<String, dynamic> json) {
    normal = json['normal'];
    mini = json['mini'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['normal'] = normal;
    _data['mini'] = mini;
    return _data;
  }
}

class Live {
  Live({
    required this.startStream,
    this.endStream,
  });
  late final int startStream;
  late final int? endStream;

  Live.fromJson(Map<String, dynamic> json) {
    startStream = json['start_stream'];
    endStream = (json['end_stream'] == null) ? null : json['end_stream'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_stream'] = startStream;
    _data['end_stream'] = endStream;
    return _data;
  }
}
