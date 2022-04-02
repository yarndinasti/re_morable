class HomeModel {
  HomeModel({
    required this.slideshow,
    required this.videoList,
  });
  late final List<Slideshow> slideshow;
  late final List<VideoList> videoList;

  HomeModel.fromJson(Map<String, dynamic> json) {
    slideshow =
        List.from(json['slideshow']).map((e) => Slideshow.fromJson(e)).toList();
    videoList = List.from(json['video_list'])
        .map((e) => VideoList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slideshow'] = slideshow.map((e) => e.toJson()).toList();
    _data['video_list'] = videoList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Slideshow {
  Slideshow({
    required this.thumbnail,
    required this.title,
    required this.url,
  });
  late final String thumbnail;
  late final String title;
  late final String url;

  Slideshow.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['thumbnail'] = thumbnail;
    _data['title'] = title;
    _data['url'] = url;
    return _data;
  }
}

class VideoList {
  VideoList({
    required this.id,
    required this.title,
    required this.published,
    required this.thumbnail,
    required this.miniThumbnail,
    required this.live,
    required this.member,
  });
  late final String id;
  late final String title;
  late final int published;
  late final String thumbnail;
  late final String miniThumbnail;
  late final Live live;
  late final Member member;

  VideoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    published = json['published'];
    thumbnail = json['thumbnail'];
    miniThumbnail = json['mini_thumbnail'];
    live = Live.fromJson(json['live']);
    member = Member.fromJson(json['member']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['published'] = published;
    _data['thumbnail'] = thumbnail;
    _data['mini_thumbnail'] = miniThumbnail;
    _data['live'] = live.toJson();
    _data['member'] = member.toJson();
    return _data;
  }
}

class Live {
  Live({
    required this.liveStatus,
    required this.startTime,
  });
  late final String liveStatus;
  late final int startTime;

  Live.fromJson(Map<String, dynamic> json) {
    liveStatus = json['live_status'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['live_status'] = liveStatus;
    _data['start_time'] = startTime;
    return _data;
  }
}

class Member {
  Member({
    required this.slug,
    required this.name,
    required this.gen,
  });
  late final String slug;
  late final String name;
  late final int gen;

  Member.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    gen = json['gen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slug'] = slug;
    _data['name'] = name;
    _data['gen'] = gen;
    return _data;
  }
}
