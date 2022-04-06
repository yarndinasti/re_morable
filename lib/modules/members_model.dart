class MembersModel {
  MembersModel({
    required this.members,
  });
  late final List<Members> members;

  MembersModel.fromJson(Map<String, dynamic> json) {
    members =
        List.from(json['members']).map((e) => Members.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['members'] = members.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Members {
  Members({
    required this.name,
    required this.slug,
    required this.channelId,
    required this.twitter,
    required this.instagram,
    this.facebook,
    required this.donate,
    required this.description,
    required this.birthday,
    required this.creator,
  });
  late final String name;
  late final String slug;
  late final String channelId;
  late final String twitter;
  late final String instagram;
  late final String? facebook;
  late final Donate donate;
  late final String description;
  late final String birthday;
  late final Creator creator;

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    channelId = json['channelId'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    facebook = (json['facebook'] == null) ? null : json['facebook'];
    donate = Donate.fromJson(json['donate']);
    description = json['description'];
    birthday = json['birthday'];
    creator = Creator.fromJson(json['creator']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['slug'] = slug;
    _data['channelId'] = channelId;
    _data['twitter'] = twitter;
    _data['instagram'] = instagram;
    _data['facebook'] = facebook;
    _data['donate'] = donate.toJson();
    _data['description'] = description;
    _data['birthday'] = birthday;
    _data['creator'] = creator.toJson();
    return _data;
  }
}

class Donate {
  Donate({
    required this.trakteer,
    this.karyakarsa,
    required this.steamlabs,
  });
  late final String trakteer;
  late final String? karyakarsa;
  late final String steamlabs;

  Donate.fromJson(Map<String, dynamic> json) {
    trakteer = json['trakteer'];
    karyakarsa = (json['karyakarsa'] == null) ? null : json['karyakarsa'];
    steamlabs = json['steamlabs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trakteer'] = trakteer;
    _data['karyakarsa'] = karyakarsa;
    _data['steamlabs'] = steamlabs;
    return _data;
  }
}

class Creator {
  Creator({
    required this.ilustrator,
    required this.riging,
  });
  late final String ilustrator;
  late final String riging;

  Creator.fromJson(Map<String, dynamic> json) {
    ilustrator = json['ilustrator'];
    riging = json['riging'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ilustrator'] = ilustrator;
    _data['riging'] = riging;
    return _data;
  }
}
